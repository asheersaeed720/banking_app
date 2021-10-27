import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:background_locator/background_locator.dart';
import 'package:banking_app/1_src/auth/user_model.dart';
import 'package:banking_app/1_src/auth/views/auth_screen.dart';
import 'package:banking_app/1_src/network_manager.dart';
import 'package:banking_app/utils/custom_snack_bar.dart';
import 'package:banking_app/utils/db_ref.dart';
import 'package:banking_app/utils/display_toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetXNetworkManager {
  final GetStorage _getStorage = GetStorage();

  final CollectionReference _userReference = FirebaseFirestore.instance.collection(DBRef.users);

  bool disableWhileLoad = false;

  Map currentUserData = {};

  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newObscureVal) {
    _obscureText = newObscureVal;
    update();
  }

  bool isLoggedIn = false;

  UserModel userModel = UserModel();

  @override
  void onInit() {
    currentUserData = getCurrentUser();
    isLoggedIn = _getStorage.read('isLoggedIn') == null ? false : true;
    super.onInit();
  }

  Future<void> logInUser() async {
    try {
      disableWhileLoad = true;
      update();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      if (userCredential.user != null) {
        final res = await _userReference.doc(userCredential.user!.uid).get();
        Get.offAllNamed(AuthScreen.routeName);
        Map<String, dynamic> data = {
          "uid": userCredential.user!.uid,
          "name": res['name'],
          "email": userModel.email,
        };
        GetStorage().write('user', data);
        GetStorage().write('isLoggedIn', true);
        currentUserData = getCurrentUser();
        isLoggedIn = _getStorage.read('isLoggedIn');
        disableWhileLoad = false;
        update();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayToastMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        displayToastMessage('Wrong password');
      } else {
        log(e.code);
      }
      disableWhileLoad = false;
      update();
    } on TimeoutException catch (_) {
      disableWhileLoad = false;
      update();
      customSnackBar('Error', 'Network error, please try again later');
    } on SocketException catch (_) {
      disableWhileLoad = false;
      update();
      customSnackBar('Error', 'Network error, please try again later');
    } catch (e) {
      disableWhileLoad = false;
      update();
      log(e.toString());
    }
  }

  Future<void> signUpUser() async {
    try {
      disableWhileLoad = true;
      update();
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      if (userCredential.user != null) {
        Get.offAllNamed(AuthScreen.routeName);
        disableWhileLoad = true;
        Map<String, dynamic> data = {
          "uid": userCredential.user!.uid,
          "name": userModel.name,
          "email": userModel.email,
        };
        _userReference.doc(userCredential.user!.uid).set(data);
        GetStorage().write('user', data);
        GetStorage().write('isLoggedIn', true);
        currentUserData = getCurrentUser();
        isLoggedIn = _getStorage.read('isLoggedIn');
        disableWhileLoad = false;
        update();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        displayToastMessage('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        displayToastMessage('Email aleady exist');
      } else {
        log(e.code);
      }
      disableWhileLoad = false;
      update();
    } on TimeoutException catch (_) {
      disableWhileLoad = false;
      update();
      customSnackBar('Error', 'Network error, please try again later');
    } on SocketException catch (_) {
      disableWhileLoad = false;
      update();
      customSnackBar('Error', 'Network error, please try again later');
    } catch (e) {
      disableWhileLoad = false;
      update();
      log(e.toString());
    }
  }

  Map getCurrentUser() {
    Map userData = _getStorage.read('user') ?? {};
    if (userData.isNotEmpty) {
      Map user = userData;
      log('$userData', name: 'user');
      return user;
    }
    return {};
  }

  signOutUser() async {
    Get.back();
    disableWhileLoad = true;
    update();
    _getStorage.remove('isLoggedIn');
    _getStorage.remove('user');
    await BackgroundLocator.unRegisterLocationUpdate();
    await FirebaseAuth.instance.signOut();
    // await BackgroundLocator.isServiceRunning();
    Get.offAndToNamed(AuthScreen.routeName);
    disableWhileLoad = false;
    update();
    displayToastMessage('Logout');
  }
}
