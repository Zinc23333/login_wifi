import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notify {
  static final Notify _instance = Notify._internal();
  factory Notify() => _instance;
  Notify._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  void initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('normal', '普通通知',
        channelDescription: '后台模式下登陆的通知', importance: Importance.high, priority: Priority.high, visibility: NotificationVisibility.public);

    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(categoryIdentifier: "plainCategory");
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);

    await _notificationsPlugin.show(1, title, body, platformChannelSpecifics, payload: "return");
  }

  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails() => _notificationsPlugin.getNotificationAppLaunchDetails();
}
