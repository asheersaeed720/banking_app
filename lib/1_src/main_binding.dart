import 'package:banking_app/1_src/auth/auth_controller.dart';
import 'package:banking_app/1_src/network_manager.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetXNetworkManager(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}
