import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/controller/api_controller.dart';
import 'package:getx_practice/controller/auth_controller.dart';
import 'package:getx_practice/controller/maps_controller.dart';
import 'package:getx_practice/controller/notification_controller.dart';
import 'package:getx_practice/screens/google_maps.dart';
import 'package:getx_practice/services/local_notification.dart';

class HomeScreen extends GetWidget<AuthController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var apicontroller = Get.put(ApiController());
    var notificationController = Get.put(NotificationController());
    var mapController = Get.put(MapsController());
    return Scaffold(
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 20,
            ),
            const Center(
                child: Text("HOME SCREEN",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Center(child: Text("${controller.user}", style: const TextStyle(fontSize: 20))),
            TextButton(
              onPressed: () {
                controller.signout();
              },
              child: const Text("Sign Out"),
            ),
            TextButton(
                onPressed: () {
                  apicontroller.fetchdata();
                  notificationController.getToken();
                },
                child: const Text("Fetch data")),
            Obx(
              () => SizedBox(
                height: MediaQuery.of(context).size.height / 2.9,
                child: apicontroller.loading == RxBool(true)
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: apicontroller.product.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text("${apicontroller.product[index].name}");
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(),
                ),
                controller: apicontroller.namecontroller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "job title",
                ),
                controller: apicontroller.jobtitlecontroller,
              ),
            ),
            TextButton(
                onPressed: () {
                  apicontroller.postdata();
                },
                child: const Text("Post data")),
            TextButton(
                onPressed: () {
                  apicontroller.putdata();
                },
                child: const Text("Put data")),
            TextButton(
                onPressed: () {
                  apicontroller.deletedata();
                },
                child: const Text("delete data")),
            Obx(
              () => apicontroller.loading == RxBool(true)
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(apicontroller.usermodel.value.id ?? 'loading...!'),
                        Text(apicontroller.usermodel.value.name ?? 'loading...!'),
                        Text(apicontroller.usermodel.value.job ?? 'loading...!')
                      ],
                    ),
            ),
            TextButton(
              onPressed: () {
                mapController.requestPermission();
                Get.to(() => const GoogleMapsScreen());
              },
              child: const Text('Open Maps'),
            ),
            TextButton(
              onPressed: () {
                // LocalNotifications.displayNotification(
                //     'Apple Notification', 'See to see it working');
              },
              child: const Text('LOCAL NOTIFICATION'),
            ),
          ],
        ),
      ),
    );
  }
}
