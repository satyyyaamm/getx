import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/controller/api_controller.dart';
import 'package:getx_practice/controller/auth_controller.dart';

class HomeScreen extends GetWidget<AuthController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var apicontroller = Get.put(ApiController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("HOME SCREEN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("${controller.user}", style: const TextStyle(fontSize: 20)),
            TextButton(
              onPressed: () {
                controller.signout();
              },
              child: const Text("Sign Out"),
            ),
            TextButton(
                onPressed: () {
                  apicontroller.fetchdata();
                },
                child: const Text("Fetch data")),
            Obx(
              () => SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: apicontroller.loading == true
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: apicontroller.product.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text("${apicontroller.product[index].name}");
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
