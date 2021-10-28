import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:math' show cos, sqrt, asin;
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/home/home_controller.dart';
import 'package:banking_app/1_src/location/location_callback_handler.dart';
import 'package:banking_app/1_src/location/location_file_manager.dart';
import 'package:banking_app/1_src/location/location_service_repository.dart';
import 'package:banking_app/utils/db_ref.dart';
import 'package:banking_app/utils/display_toast_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  final _authController = Get.put(AuthController());
  final _homeController = Get.put(HomeController());

  final CollectionReference _userReference = FirebaseFirestore.instance.collection(DBRef.users);

  ReceivePort port = ReceivePort();

  String logStr = '';
  bool isRunning = false;
  LocationDto? lastLocation;

  @override
  void onInit() {
    super.onInit();

    if (IsolateNameServer.lookupPortByName(LocationServiceRepository.isolateName) != null) {
      IsolateNameServer.removePortNameMapping(LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(port.sendPort, LocationServiceRepository.isolateName);

    port.listen(
      (dynamic data) async {
        await updateUI(data);
      },
    );
    initPlatformState();
  }

  Future<void> updateUI(dynamic data) async {
    final log = await LocationFileManager.readLogFile();

    await _updateNotificationText(data);

    // ignore: unnecessary_null_comparison
    if (data != null) {
      lastLocation = data;
    }
    logStr = log;
    update();
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a =
        0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> _updateNotificationText(dynamic locationData) async {
    if (locationData == null) {
      return;
    }

    if (_authController.connectionType != 0) {
      var userData = await _userReference.doc(_authController.currentUserData['uid']).get();
      var lat = userData.get('latitude');
      var lng = userData.get('longitude');

      // log('Current Latlng $lat, $lng');
      // log('Upcoming Latlng ${locationData.latitude}, ${locationData.longitude}');

      if ((lat != locationData.latitude) && (lng != locationData.longitude)) {
        double totalDistance =
            calculateDistance(lat, lng, locationData.latitude, locationData.longitude);

        if (totalDistance >= 1) {
          log('distance $totalDistance');
          await _userReference.doc(_authController.currentUserData['uid']).update({
            "latitude": locationData.latitude,
            "longitude": locationData.longitude,
          });
          _homeController.getNearbyRestaurant();

          await BackgroundLocator.updateNotificationText(
            title: "Discount Reminder",
            // msg: "${DateTime.now()}",
            bigMsg: "Finding discounts in nearby restaurant...",
          );
        } else {
          log('else distance $totalDistance');
        }
      } else {
        log('Same Location');
        print('saaaaaaaaaaaaaam Location');
      }
    }
  }

  Future<void> initPlatformState() async {
    // ignore: avoid_print
    print('Initializing...');
    await BackgroundLocator.initialize();
    logStr = await LocationFileManager.readLogFile();
    // ignore: avoid_print
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    isRunning = _isRunning;
    // ignore: avoid_print
    print('Running ${isRunning.toString()}');
    update();
  }

  void onStop() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    isRunning = _isRunning;
    update();
  }

  void onStartLocation() async {
    if (await _checkLocationPermission()) {
      await _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();

      isRunning = _isRunning;
      lastLocation = null;
      update();
    } else {
      displayToastMessage('Permission denied');
    }
  }

  Future<bool> _checkLocationPermission() async {
    final access = await Permission.locationAlways.status;
    switch (access) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await Permission.locationAlways.request();
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      case PermissionStatus.granted:
        return true;
      default:
        return false;
    }
  }

  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      initDataCallback: data,
      disposeCallback: LocationCallbackHandler.disposeCallback,
      iosSettings: const IOSSettings(accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0.0),
      autoStop: false,
      androidSettings: const AndroidSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        interval: 5,
        distanceFilter: 0.0,
        client: LocationClient.google,
        androidNotificationSettings: AndroidNotificationSettings(
          notificationChannelName: 'Location tracking',
          notificationTitle: 'Start Location Tracking',
          notificationMsg: 'Track location in background',
          notificationBigMsg:
              'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
          notificationIconColor: Colors.grey,
          notificationTapCallback: LocationCallbackHandler.notificationCallback,
        ),
      ),
    );
  }
}
