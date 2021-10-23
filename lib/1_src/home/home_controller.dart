import 'dart:developer';

import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/home/bank_card_model.dart';
import 'package:banking_app/utils/api.dart';
import 'package:banking_app/utils/db_ref.dart';
import 'package:banking_app/utils/display_toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _authController = Get.find<AuthController>();

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
          .then((value) {
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
      await _bankCardReference.doc(id).delete().then((value) {
        displayToastMessage('Card Remove');
      }).catchError((e) {
        log('Error $e');
      });
    } else {
      displayToastMessage('Network error, try again later');
    }
  }
}
