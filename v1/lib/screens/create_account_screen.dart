import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/controller/auth_controller.dart';

class CreatAccountScreen extends GetWidget<AuthController> {
  CreatAccountScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("CREATE ACCOUNT SCREEN",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _emailController,
            ),
            TextFormField(
              controller: _passwordController,
            ),
            TextButton(
                onPressed: () {
                  controller.createAccount(
                      email: _emailController.text, password: _passwordController.text);
                },
                child: const Text('Sign in'))
          ]),
    );
  }
}
