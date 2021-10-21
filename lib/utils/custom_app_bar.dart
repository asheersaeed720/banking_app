import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/profile/user_profile_screen.dart';
import 'package:banking_app/utils/app_theme.dart';
import 'package:banking_app/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar customAppBar(context, appBarTxt, {color = Colors.white}) {
  return AppBar(
    title: Text(
      '$appBarTxt',
      style: const TextStyle(
        fontFamily: AppTheme.fontName,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: AppTheme.nearBlack,
      ),
    ),
    elevation: 0,
    backgroundColor: color,
    iconTheme: const IconThemeData(color: Colors.black87),
    actions: [
      PopupMenuButton(
        elevation: 20,
        enabled: true,
        onSelected: (value) {
          if (value == '1') {
            Navigator.of(context).pushNamed(UserProfileScreen.routeName);
          } else if (value == '2') {
            showAlertDialog(
              context,
              'Logout',
              'Are you sure you want to logout!',
              () {
                Get.find<AuthController>().signOutUser();
              },
            );
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            child: Text(
              "My Profile",
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            value: "1",
          ),
          const PopupMenuItem(
            child: Text(
              "Logout",
              style: TextStyle(fontFamily: AppTheme.fontName),
            ),
            value: "2",
          ),
        ],
      ),
    ],
  );
}
