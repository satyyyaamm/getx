import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/controller/auth_controller.dart';
import 'package:getx_practice/screens/create_account_screen.dart';
import 'package:getx_practice/screens/phone_autentication_screen.dart';

class LoginScreen extends GetWidget<AuthController> {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("LOGIN SCREEN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _emailController,
            ),
            TextFormField(
              controller: _passwordController,
            ),
            TextButton(
                onPressed: () {
                  controller.login(
                      email: _emailController.text, password: _passwordController.text);
                },
                child: const Text('Login')),
            TextButton(
                onPressed: () {
                  Get.to(CreatAccountScreen());
                },
                child: const Text('Sign In')),
            TextButton(
                onPressed: () {
                  controller.loginWithGoogle();
                },
                child: const Text('sign in with google')),
            TextButton(
                onPressed: () {
                  Get.to(() => PhoneAuthenticationScreen());
                },
                child: const Text('sign in with Phone number'))
          ]),
    );
  }
}
