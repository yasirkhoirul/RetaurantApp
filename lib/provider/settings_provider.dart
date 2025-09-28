import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _notification = false;
  bool get notifiacion => _notification;

  void setNotification(bool data) {
    _notification = data;
    notifyListeners();
  }
}
