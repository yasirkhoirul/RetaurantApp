import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/api/data/restoran_api.dart';
import 'package:restaurant_app/static/status.dart';

class ReviewProvider extends ChangeNotifier {
  Apiservice api;
  ReviewProvider(this.api);
  Status _status = StatusIdle();
  Status get status => _status;

  Future onSubmit(String datausername, String datadeskripsi, String id) async {
    _status = Statusloading();
    try {
      final hasil = await api.postReview(id, datausername, datadeskripsi);
      if (hasil.error) {
        _status = Statuserror(message: "terjadi kesalhan ${hasil.message}");
      } else {
        _status = StatussuksesPostreview(response: hasil);
      }
    } on SocketException {
      _status = Statuserror(message: "tidak ada internet");
    } catch (e) {
      _status = Statuserror(message: e.toString());
    } finally {
      notifyListeners();
    }
  }
}
