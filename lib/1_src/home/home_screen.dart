import 'package:auto_size_text/auto_size_text.dart';
import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/home/add_card_bottom_sheet.dart';
import 'package:banking_app/1_src/home/home_controller.dart';
import 'package:banking_app/1_src/home/models/bank_card_model.dart';
import 'package:banking_app/utils/custom_app_bar.dart';
import 'package:banking_app/utils/custom_dialog.dart';
import 'package:banking_app/widgets/cache_img_widget.dart';
import 'package:banking_app/widgets/loading_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authController = Get.find<AuthController>();
  final _homeController = Get.put(HomeController());

  @override
  void initState() {
    _homeController.determinePosition();
    _homeController.getNearbyRestaurant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: customAppBar(context, 'Home'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<AuthController>(
                builder: (_) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        _homeController.getNearbyRestaurant();
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(32.0),
                        child: Image.asset('assets/images/dummy_profile.png'),
                      ),
                      title: Text('${_authController.currentUserData['name']}'),
                      subtitle: Text('${_authController.currentUserData['email']}'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.blue),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              StreamBuilder<QuerySnapshot<BankCardModel>>(
                stream: _homeController.getUserBankCards(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<BankCardModel>> bankCardsList =
                        snapshot.data!.docs as List<QueryDocumentSnapshot<BankCardModel>>;
                    return bankCardsList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 32.0),
                                Image.asset('assets/icons/debit_cards.png'),
                                const SizedBox(height: 8.0),
                                Text('No Card added yet!',
                                    style: Theme.of(context).textTheme.bodyText1),
                                const SizedBox(height: 32.0),
                              ],
                            ),
                          )
                        : CarouselSlider(
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.6,
                              viewportFraction: 0.9,
                              enableInfiniteScroll: false,
                            ),
                            items: [
                              ...(bankCardsList).map((e) {
                                return _buildCardViewItem(e);
                              }).toList()
                            ],
                          );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "${snapshot.error}",
                      ),
                    );
                  }
                  return const LoadingWidget();
                },
              ),
              const SizedBox(height: 18.0),
              Center(
                child: Image.asset('assets/images/divider.jpg',
                    width: MediaQuery.of(context).size.width * 0.9),
              ),
              const SizedBox(height: 6.0),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                leading: Image.asset('assets/icons/discount.png', width: 30.0),
                title: Text('Discounts', style: Theme.of(context).textTheme.headline1),
              ),
              const SizedBox(height: 6.0),
              Column(
                children: [
                  _buildDiscountViewItem(),
                  _buildDiscountViewItem(),
                  _buildDiscountViewItem(),
                  _buildDiscountViewItem(),
                  _buildDiscountViewItem(),
                  _buildDiscountViewItem(),
                  _buildDiscountViewItem(),
                ],
              )
              // ListView.builder(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   itemCount: 6,
              //   shrinkWrap: true,
              //   itemBuilder: (context, i) {
              //     return _buildDiscountViewItem();
              //   },
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[700],
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => showAddCardBottomModelSheet(),
      ),
    );
  }

  Widget _buildCardViewItem(QueryDocumentSnapshot<BankCardModel> bankCardItem) {
    DateTime dateTime = DateTime.parse(bankCardItem.data().expiryDate);
    String formattedDate = DateFormat.yMMMd().format(dateTime);
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                CacheImgWidget(
                  bankCardItem.data().cardImg,
                  width: double.infinity,
                  height: 158.0,
                  borderRadius: 10.0,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: AutoSizeText(
                    bankCardItem.data().bankName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Type: ${bankCardItem.data().cardType}',
                  style: const TextStyle(fontSize: 14.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Expiry date: $formattedDate',
                  style: const TextStyle(fontSize: 14.0),
                ),
                const Spacer(),
                const Divider(),
                InkWell(
                  onTap: () => showAlertDialog(
                    context,
                    'Delete',
                    'Are you sure, want to delete',
                    () {
                      Get.back();
                      _homeController.removeUserCard(bankCardItem.id);
                    },
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Theme.of(context).errorColor),
                      const SizedBox(width: 8.0),
                      Text(
                        "Remove",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiscountViewItem() {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.restaurant_outlined),
        title: Text('Shagufta Restaurant'),
        subtitle: Text('40% Discount'),
      ),
    );
  }
}
