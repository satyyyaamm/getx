import 'package:get/get.dart';
import 'package:getx_practice/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  // dependency injection
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
