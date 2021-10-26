import 'dart:developer';
import 'dart:io';

import 'package:banking_app/utils/display_toast_message.dart';
import 'package:dio/dio.dart';

class ApiService {
  Future<Response> getHttpReq(String url) async {
    try {
      return await Dio().get(url);
    } on SocketException catch (_) {
      displayToastMessage('Network errro, try again later');
      rethrow;
    } catch (e) {
      log('$e', name: 'getResponse');
      rethrow;
    }
  }
}
