import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Request notification permission
Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.request();

  if (status.isGranted) {
    Get.snackbar( 'Permission granted', 'Permission granted proceed with notifications access');
  } else if (status.isPermanentlyDenied) {
    Get.snackbar(
      'Notification permission permanently denied. Please enable it in the app settings.','Notification permission denied');
    openAppSettings();
  } else {
    Get.snackbar(
       'permission denied','Notification permission denied',
    );
  }
}


  // Show notification
  Future<void> showNotification(String message) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'location_channel',
      'Location Updates',
      // 'Channel for location update notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification',
      message,
      platformChannelSpecifics,
    );
  }
}
