import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/api/data/restoran_api.dart';
import 'package:restaurant_app/static/status.dart';

class RestoranlistProvider extends ChangeNotifier {
  final Apiservice api;

  RestoranlistProvider({required this.api});

  Status _status = StatusIdle();
  Status get status => _status;

  Future fetchdata() async {
    _status = Statusloading();
    try {
      final data = await api.getRestoranlist();
      if (data.error) {
        _status = Statuserror(message: "terjadi kesalhan ${data.message}");
      } else {
        _status = Statussukses(datarestoran: data);
      }
    } on SocketException {
      _status = Statuserror(
        message: "tidak ada koneksi internet silahkan coba lagi",
      );
    } catch (e) {
      _status = Statuserror(message: "terjadi kesalahan silahkan coba lagi $e");
    } finally {
      notifyListeners();
    }
  }
}
