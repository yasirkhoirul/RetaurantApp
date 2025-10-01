import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_app/api/data/restoran_api.dart';
import 'package:restaurant_app/static/status.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  Apiservice api;
  Status _status = StatusIdle();
  Status get status => _status;
  DetailRestaurantProvider({required this.api});

  Future getDatadetail(String id) async {
    _status = Statusloading();
    try {
      final data = await api.getDetailRestoran(id);
      if (data.error) {
        _status = Statuserror(message: "terjadi kesalahan ${data.error}");
      } else {
        _status = Statussuksesdetail(data: data);
      }
    } on SocketException {
      _status = Statuserror(message: "tidak ada internet");
    } catch (e) {
      _status = Statuserror(message: "terjadi kesalahan yang tidak terduga $e");
    } finally {
      notifyListeners();
    }
  }
}
