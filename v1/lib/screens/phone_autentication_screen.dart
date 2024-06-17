import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/controller/auth_controller.dart';

class PhoneAuthenticationScreen extends GetWidget<AuthController> {
  PhoneAuthenticationScreen({Key? key}) : super(key: key);
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _phoneController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Phone number",
          ),
        ),
        TextButton(
            onPressed: () {
              controller.phoneAuthentication(_phoneController.text, context);
            },
            child: const Text('Login'))
      ],
    ));
  }
}
