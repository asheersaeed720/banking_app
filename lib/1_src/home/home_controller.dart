import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:banking_app/1_src/api_service.dart';
import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/home/models/bank_card_model.dart';
import 'package:banking_app/1_src/home/models/discount_model.dart';
import 'package:banking_app/1_src/home/models/nearby_place.dart';
import 'package:banking_app/utils/api.dart';
import 'package:banking_app/utils/db_ref.dart';
import 'package:banking_app/utils/display_toast_message.dart';
import 'package:banking_app/utils/secret.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _authController = Get.find<AuthController>();
  final ApiService _apiService = ApiService();

  final CollectionReference _userReference = FirebaseFirestore.instance.collection(DBRef.users);

  final CollectionReference _restaurantsReference =
      FirebaseFirestore.instance.collection(DBRef.restaurants);

  final _bankCardReference =
      FirebaseFirestore.instance.collection(DBRef.cards).withConverter<BankCardModel>(
            fromFirestore: (snapshot, _) => BankCardModel.fromJson(snapshot.data()!),
            toFirestore: (trip, _) => trip.toJson(),
          );

  Stream<QuerySnapshot<BankCardModel>> getUserBankCards() {
    return _bankCardReference
        .where("uid", isEqualTo: _authController.currentUserData['uid'])
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  final _discountsRef =
      FirebaseFirestore.instance.collection(DBRef.discounts).withConverter<DiscountModel>(
            fromFirestore: (snapshot, _) => DiscountModel.fromJson(snapshot.data()!),
            toFirestore: (trip, _) => trip.toJson(),
          );

  Stream<QuerySnapshot<DiscountModel>> getDiscounts() {
    return _discountsRef.snapshots();
  }

  Future<void> addUserCard({
    required String bankName,
    required String cardType,
    required String expiryDate,
  }) async {
    if (_authController.connectionType != 0) {
      String imgURL = '';
      if (cardType == 'Silver') {
        imgURL =
            '$imgURLFirebaseStorage/sliver_card.png?alt=media&token=842b016d-564e-4304-a15c-c3f52efcf983';
      } else if (cardType == 'Gold') {
        imgURL =
            '$imgURLFirebaseStorage/gold_card.png?alt=media&token=1a871d97-8ddb-47b3-96e4-65b0a4011a1f';
      } else {
        imgURL =
            '$imgURLFirebaseStorage/platinum_card.png?alt=media&token=d07bb0c6-6181-44c7-a0dc-8dc37d755a5a';
      }
      Get.back();

      await _bankCardReference
          .add(BankCardModel(
        uid: _authController.currentUserData['uid'],
        bankName: bankName,
        cardImg: imgURL,
        cardType: cardType,
        expiryDate: expiryDate,
        createdAt: Timestamp.now(),
      ))
          .then((_) {
        displayToastMessage('Card added');
      }).catchError((e) {
        log('Error $e');
      });
    } else {
      displayToastMessage('Network error, try again later');
    }
  }

  Future<void> removeUserCard(String id) async {
    if (_authController.connectionType != 0) {
      await _bankCardReference.doc(id).delete().then((_) {
        displayToastMessage('Card Remove');
      }).catchError((e) {
        log('Error $e');
      });
    } else {
      displayToastMessage('Network error, try again later');
    }
  }

  void getNearbyRestaurant() async {
    _userReference.doc(_authController.currentUserData['uid']).get().then((userData) async {
      var lat = userData.get('latitude');
      var long = userData.get('longitude');
      String url =
          '$googleApi/place/nearbysearch/json?location=$lat%2C$long&radius=1500&type=restaurant&key=${Secret.googleApiKey}';
      var res = await _apiService.getHttpReq(url);
      if (res.statusCode == 200) {
        List<NearbyPlace> nearbyPlace =
            (res.data['results'] as List).map((e) => NearbyPlace.fromJson(e)).toList();
        List<String> nearbyPlaceIdFromApi = [];
        for (var element in nearbyPlace) {
          nearbyPlaceIdFromApi.add('${element.placeId}');
        }

        QuerySnapshot querySnapshot = await _restaurantsReference.get();

        List nearbyPlaceIdFromDB = querySnapshot.docs.map((doc) => doc.get('place_id')).toList();

        for (var idFromDB in nearbyPlaceIdFromDB) {
          if (nearbyPlaceIdFromApi.contains(idFromDB)) {
            int index = nearbyPlaceIdFromApi.indexOf(idFromDB);
            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                // id: DateTime.now().microsecondsSinceEpoch.remainder(100000),
                id: index,
                channelKey: 'nearby_restaurant_channel',
                title: '${nearbyPlace[index].name}',
                body: '30% Discount',
                notificationLayout: NotificationLayout.Default,
                createdSource: NotificationSource.Local,
                displayOnForeground: true,
                displayOnBackground: true,
              ),
            );
            log('${nearbyPlace[index].name}');
          } else {
            log('Not exist');
          }
        }
      }
    });
  }
}
