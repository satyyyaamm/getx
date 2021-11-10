import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void intialise() {
    // android specific settings and permissons
    const _android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    // iOS specific settings and permissions
    const _iOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    // initializing the settings for android an Ios and other platforms aswell
    const InitializationSettings initializationSettings =
        InitializationSettings(android: _android, iOS: _iOS);
    // passing down the initialized settings to the main local notification
    // plugin
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const android = AndroidNotificationDetails('satyyyaamm', 'satyyyaamm channel',
          importance: Importance.max, priority: Priority.high);
      const NotificationDetails notificationDetails = NotificationDetails(android: android);
      _flutterLocalNotificationsPlugin.show(
          id, message.notification!.title, message.notification!.body, notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }
}
