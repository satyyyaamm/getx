import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/controller/auth_controller.dart';
import 'package:getx_practice/screens/home_screen.dart';
import 'package:getx_practice/screens/login_screen.dart';

class Wrapper extends GetWidget<AuthController> {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<AuthController>().user != null ? const HomeScreen() : LoginScreen();
    });
  }
}
