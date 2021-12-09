import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_practice/screens/wrapper.dart';
import 'package:getx_practice/services/local_notification.dart';
import 'bindings/auth_binding.dart';

// this is a top level function
// this function is called when the your applications is in terminated state
// and you recieve and background notification
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print('message from backgroundHandler function ${message.notification!.title}');
  print('message from backgroundHandler function ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotifications.intialise();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      title: 'GetX Practice',
      home: const Wrapper(),
    );
  }
}
