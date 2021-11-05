import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/controller/notification_controller.dart';

class NotificationClickTestScren extends StatelessWidget {
  const NotificationClickTestScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notificationController = Get.put(NotificationController());
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Center(
            child: Text(
                  notificationController.messageFromNotification.toString(),
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
          ))
        ],
      ),
    );
  }
}
