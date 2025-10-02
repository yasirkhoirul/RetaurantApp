import 'package:restaurant_app/api/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  final SharedPreferences _service;
  SettingService(this._service);

  static const String settingnotif = "settingnotif";
  static const String settingtheme = "settingtheme";

  Future savesetting(Setting data) async {
    try {
      await _service.setBool(settingnotif, data.notif);
      await _service.setBool(settingtheme, data.theme);
    } catch (e) {
      throw Exception("terjadi kesalahan dalam melakukan penyimpanan data");
    }
  }

  

  Setting getData() {
    return Setting(
      notif: _service.getBool(settingnotif) ?? false,
      theme: _service.getBool(settingtheme) ?? false,
    );
  }
}
