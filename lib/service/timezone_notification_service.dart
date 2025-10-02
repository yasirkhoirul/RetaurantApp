import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimezoneNotificationService {

  Future<void> init() async {
   const initializationSettingsAndroid = AndroidInitializationSettings(
     'app_icon',
   );
   const initializationSettingsDarwin = DarwinInitializationSettings(
     requestAlertPermission: false,
     requestBadgePermission: false,
     requestSoundPermission: false,
   );
   const initializationSettings = InitializationSettings(
     android: initializationSettingsAndroid,
     iOS: initializationSettingsDarwin,
   );
   await FlutterLocalNotificationsPlugin().initialize(
     initializationSettings,
   );
 }

  Future<void> configureLocalTImezone() async {
    tz.initializeTimeZones();

    final timezoneName = await FlutterTimezone.getLocalTimezone();
    final String timzone = timezoneName.identifier;

    tz.setLocalLocation(tz.getLocation(timzone));
  }

  tz.TZDateTime _nextInstanceofelevenam() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      11,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

   Future<bool> _isAndroidPermissionGranted() async {
   return await FlutterLocalNotificationsPlugin()
           .resolvePlatformSpecificImplementation<
               AndroidFlutterLocalNotificationsPlugin>()
           ?.areNotificationsEnabled() ??
       false;
 }

  Future<bool> _requestExactAlarmsPermission() async {
    return await FlutterLocalNotificationsPlugin()
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<bool?> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iOSImplementation = FlutterLocalNotificationsPlugin()
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();
        return await iOSImplementation?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        final notificationEnabled = await _isAndroidPermissionGranted();
        if (!notificationEnabled) {
          final requestNotificationsPermission =
              await _isAndroidPermissionGranted();
          return requestNotificationsPermission;
        }
        return notificationEnabled;
      } else {
        return false;
      }
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final androidImplementation = FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final requestNotificationsPermission = await androidImplementation
          ?.requestNotificationsPermission();
      final notificationEnabled = await _isAndroidPermissionGranted();
      final requestAlarmEnabled = await _requestExactAlarmsPermission();
      return (requestNotificationsPermission ?? false) &&
          notificationEnabled &&
          requestAlarmEnabled;
    } else {
      return false;
    }
  }


   Future<void> scheduleDailyTenAMNotification({
   required int id,
   String channelId = "3",
   String channelName = "Schedule Notification",
 }) async {
   final androidPlatformChannelSpecifics = AndroidNotificationDetails(
     channelId,
     channelName,
     importance: Importance.max,
     priority: Priority.high,
     ticker: 'ticker',
   );
   const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
 
   final notificationDetails = NotificationDetails(
     android: androidPlatformChannelSpecifics,
     iOS: iOSPlatformChannelSpecifics,
   );
 
   final datetimeSchedule = _nextInstanceofelevenam();
 
   await FlutterLocalNotificationsPlugin().zonedSchedule(
     id,
     'Daily scheduled notification title',
     'This is a body of daily scheduled notification',
     datetimeSchedule,
     notificationDetails,
     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
     matchDateTimeComponents: DateTimeComponents.time,
   );
 }


 Future<List<PendingNotificationRequest>> pendingNotificationRequests() async {
   final List<PendingNotificationRequest> pendingNotificationRequests =
       await FlutterLocalNotificationsPlugin().pendingNotificationRequests();
   return pendingNotificationRequests;
 }
 
 Future<void> cancelNotification(int id) async {
   await FlutterLocalNotificationsPlugin().cancel(id);
 }
}
