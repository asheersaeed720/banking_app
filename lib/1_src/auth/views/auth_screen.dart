import 'dart:developer';

import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/auth/views/login_screen.dart';
import 'package:banking_app/1_src/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/auth';

  AuthScreen({Key? key}) : super(key: key);

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    log('${FirebaseAuth.instance.currentUser}', name: 'firebaseUser');
    log('${_authController.currentUserData}', name: 'storeUser');
    log('${_authController.isLoggedIn}', name: 'isLoggedIn');
    if (FirebaseAuth.instance.currentUser == null) {
      GetStorage getStorage = GetStorage();
      getStorage.remove('isLoggedIn');
      getStorage.remove('user');
      _authController.isLoggedIn = getStorage.read('isLoggedIn') ?? false;
      _authController.currentUserData = getStorage.read('user') ?? {};
      return const LogInScreen();
    } else {
      // return const HomeScreen();
      return const HomePage();
    }
  }
}
