import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/profile/user_profile_screen.dart';
import 'package:banking_app/utils/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Home'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<AuthController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    // leading: ClipRRect(
                    //   borderRadius: BorderRadius.circular(32.0),
                    //   child: Image.asset('assets/images/dummy_profile.png'),
                    // ),
                    title: Text('${_authController.currentUserData['name']}'),
                    subtitle: Text('${_authController.currentUserData['email']}'),
                    trailing: InkWell(
                      onTap: () {
                        Get.toNamed(UserProfileScreen.routeName);
                      },
                      child: const Text(
                        'View',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Text(
                    'Debit Card',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(height: 400.0, aspectRatio: 16 / 10),
                  items: [
                    _buildCardViewItem(),
                    _buildCardViewItem(),
                    _buildCardViewItem(),
                  ],
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[700],
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }

  Widget _buildCardViewItem() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          // margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: const BoxDecoration(),
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/debit_card.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'UBL Premium',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Available discount: 70%",
                  style: TextStyle(fontSize: 15.0),
                ),
                const Spacer(),
                const Divider(),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "View All Discounts",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).pushNamed(DiscountScreen.routeName);
                    },
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
}
