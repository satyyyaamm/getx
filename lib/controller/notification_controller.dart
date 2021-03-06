import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:getx_practice/screens/some_random_screen.dart';
import 'package:getx_practice/services/api_services.dart';
import 'package:getx_practice/services/local_notification.dart';

class NotificationController extends GetxController {
  var messageFromNotification = ''.obs;
  static String? gettoken;
  static const String _webServerKey =
      'AAAAneNfkOg:APA91bHX27iuZNhsqG28g6PiRDwUhnIau7YATzhhoTcW5jEnfKUck2ePZPZMHgrVLcwF5nvsAPV43yWO36L3CNCMVBJSQ32I53Fll8pmorH8e7FYlC5G6ciEYsudcJMK75nKxO1QTf4V';
  @override
  void onInit() {
    getInitialMessage();
    onMessage();
    onMessageOpened();
    getToken();
    super.onInit();
  }

// this is used for getting the intial message and need to run this before
// running the any notification function or method

// this alos works when the application is in terminated state and the user
// tap son the notification
  void getInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        messageFromNotification.value = message.data['extra'];
        print("messagefrom get initial message function! **=> ${message.notification!.title}");
        print("messagefrom get initial message funxtion! **=> ${message.notification!.body}");
        Get.to(() => const NotificationClickTestScren());
      }
    });
  }

  getToken() async {
    FirebaseMessaging.instance.getToken().then((token) {
      gettoken = token;
      print('token $token');
    });
  }

// this senario only get called when the applications is in the foreground
// (foreground mean) when the application is on the screen and running
  void onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print('onMessage function *=> ${message.notification!.title}');
        print('onMessage function *=> ${message.notification!.body}');
        LocalNotifications.displayNotification(message);
      }
    });
  }

// this senario only gets called when the notification is in the notification
// tray and user click on the notification and the app is running in the
// background but opened
  void onMessageOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("message from get on Message Opened function! **=> ${message.notification!.title}");
      print("message from get on Message Opened function! **=> ${message.notification!.body}");
      print(message.data['extra']);
      if (message.data['extra'] == 'login') {
        messageFromNotification.value = message.data['extra'];
        // print(messageFromNotification.value);
        Get.to(() => const NotificationClickTestScren());
      }
    });
  }

// this function is used to call request for notification via http post requests.
  static httpPostFCMNotification(
    String title,
    String body,
    // String token,
  ) async {
    print('title $title and body $body');
    // if (title != '' && body != '') {
    final response = await ApiServices.client.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_webServerKey',
      },
      body: jsonEncode(<String, dynamic>{
        "notification": {
          "body": body,
          "title": title,
          "sound": "default",
        },
        "apns": {
          "payload": {
            "aps": {"sound": "default"}
          }
        },
        "priority": "high",
        "data": {
          "clickaction": "FLUTTERNOTIFICATIONCLICK",
          "id": "1",
          "status": "done",
        },
        "to": gettoken,
      }),
    );
    print("response ------------------${response.statusCode}");
    print('send to token $gettoken');
  }
  // }
}
