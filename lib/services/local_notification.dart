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
    // request permission for ios
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // ignore: unused_element
    void onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
      print('id $id');
      print('title $title');
      print('body $body');
      print('payload $payload');
    }

    // iOS specific settings and permissions
    const _iOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    // payload
    onSelectedNotification(payload) {
      if (payload != null) {
        print('Notification payload is $payload');
      }
    }

    // initializing the settings for android an Ios and other platforms aswell
    const InitializationSettings initializationSettings =
        InitializationSettings(android: _android, iOS: _iOS);
    // passing down the initialized settings to the main local notification
    // plugin
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectedNotification,
    );
  }

  // function that initializes the android and ios notification details
  // and display notification
  static void displayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      // android notification details
      const android = AndroidNotificationDetails('satyyyaamm', 'satyyyaamm channel',
          importance: Importance.max, priority: Priority.high);
      // iOS notification details
      const ios = IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'default',
        badgeNumber: 1,
      );
      const NotificationDetails notificationDetails =
          NotificationDetails(android: android, iOS: ios);
      // displaying the notification
      _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print('Error on display notification $e');
    }
  }
}
