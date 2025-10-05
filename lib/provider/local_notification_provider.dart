import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/timezone_notification_service.dart';
import 'package:restaurant_app/static/status.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final TimezoneNotificationService _timezoneNotificationService;
  LocalNotificationProvider(this._timezoneNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  Status _status = Statusloading();
  Status get status => _status;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  Future checkPermission() async{
    _status = Statusloading();
    try {
      final permission = await _timezoneNotificationService.isAndroidPermissionGranted();
      
      _permission = permission;
    } catch (e) {
      _status =Statuserror(message: "terjadi kesalhan");
    }finally{
      notifyListeners();
    }
  }

  void setpermissision(bool? data){
    _permission = data;
    notifyListeners();
  }
  Future<void> requestPermissions() async {
    try {
      _permission = await _timezoneNotificationService
        .requestPermissions();
    } catch (e) {
      _status = Statuserror(message: 'terjadi kesalahan $e'); 
    }finally{
      notifyListeners();
    }
  }

  void scheduleDailytenAMNotification() {
    _notificationId = 1;
    _timezoneNotificationService.scheduleDailyelevenAMNotification(
      id: _notificationId,
    );
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests = await _timezoneNotificationService
        .pendingNotificationRequests();
    notifyListeners();
  }

  Future<void> cancelNotification(int id) async {
    await _timezoneNotificationService.cancelNotification(id);
  }

  Future cancelAllnotif() async {
    await _timezoneNotificationService.cancelAllnotification();
  }
}
