import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

import '../library.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission for iOS
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: $message');
      notification(message: message);
    });

    // Handle background and terminated messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });

    // Handle when the app is completely closed
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }

  Future<void> notification({required RemoteMessage message}) async {
    NotificationService().showNotification(
        id: 1,
        title: '${message.notification?.title}',
        body: "${message.notification?.body}",
        payLoad: "");
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          debugPrint(payload);
        });

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotifications);
  }

  notificationDetails() {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('alert'),
      enableLights: true,
      showBadge: true,
    );
    return NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            playSound: true,
            priority: Priority.high,
            color: Colors.transparent,
            channelDescription: channel.description,
            // sound:  UriAndroidNotificationSound("assets/alert.mp3"),
            // sound: const RawResourceAndroidNotificationSound('alert'),
            icon: "ic_launcher",
            importance: Importance.max));
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    notificationsPlugin.show(id, title, body, await notificationDetails(),
        payload: payLoad);
  }

  onSelectNotifications(NotificationResponse notificationResponse) async {
    print(notificationResponse.actionId);
  }
}
