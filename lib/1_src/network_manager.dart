import 'dart:async';
import 'dart:developer';

import 'package:banking_app/utils/custom_snack_bar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GetXNetworkManager extends GetxController {
  int connectionType = 0;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  @override
  void onInit() {
    getConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  Future<void> getConnectionType() async {
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      log('$e');
    }
    return _updateState(connectivityResult!);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        update();
        // displayToastMessage('connected via wifi');
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        update();
        // displayToastMessage('connected via mobile');
        break;
      case ConnectivityResult.none:
        connectionType = 0;
        update();
        // displayToastMessage('No Internet');
        break;
      default:
        customSnackBar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}
