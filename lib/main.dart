import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:banking_app/1_src/main_binding.dart';
import 'package:banking_app/utils/app_theme.dart';
import 'package:banking_app/utils/custom_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import '1_src/auth/views/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await AwesomeNotifications().initialize(
    'resource://drawable/ic_launcher',
    [
      NotificationChannel(
        channelKey: 'nearby_restaurant_channel',
        channelName: 'Nearby Restaurant Notifications',
        channelShowBadge: true,
        playSound: true,
        importance: NotificationImportance.High,
      ),
    ],
  );
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Banking App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: customPrimaryColor,
          errorColor: Colors.red[800],
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: AppTheme.fontName,
          textTheme: AppTheme.textTheme,
        ),
        initialBinding: MainBinding(),
        initialRoute: AuthScreen.routeName,
        getPages: customRoutes,
      );
}

Map<int, Color> color = {
  50: const Color.fromRGBO(49, 52, 69, .1),
  100: const Color.fromRGBO(49, 52, 69, .2),
  200: const Color.fromRGBO(49, 52, 69, .3),
  300: const Color.fromRGBO(49, 52, 69, .4),
  400: const Color.fromRGBO(49, 52, 69, .5),
  500: const Color.fromRGBO(49, 52, 69, .6),
  600: const Color.fromRGBO(49, 52, 69, .7),
  700: const Color.fromRGBO(49, 52, 69, .8),
  800: const Color.fromRGBO(49, 52, 69, .9),
};

MaterialColor customPrimaryColor = MaterialColor(0xFF313445, color);
