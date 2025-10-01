import 'package:flutter/material.dart';
import 'package:restaurant_app/api/model/setting.dart';
import 'package:restaurant_app/service/setting_service.dart';
import 'package:restaurant_app/static/status.dart';

class SettingProvider extends ChangeNotifier {
  SettingService settingService;
  SettingProvider({required this.settingService});

  Status _status = StatusIdle();
  Status get status => _status;

  Setting? _setting;
  Setting? get setting => _setting;

  Future saveData(Setting data) async {
    _status = Statusloading();
    try {
      await settingService.savesetting(data);
      _status = StatussuksesloaDatabase("berhasil");
    } catch (e) {
      _status = Statuserror(message: "terjadi kesalahan $e");
    } finally {
      notifyListeners();
    }
  }

  Future getdata() async {
    _status = Statusloading();
    try {
      _setting = settingService.getData();
      _status = StatussuksesloaDatabase("data berhasil diambil");
    } catch (e) {
      _status = Statuserror(message: "terjadi kesalahan $e");
    } finally {
      notifyListeners();
    }
  }
}
