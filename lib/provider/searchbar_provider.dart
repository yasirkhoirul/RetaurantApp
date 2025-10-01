import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/api/data/restoran_api.dart';
import 'package:restaurant_app/static/status.dart';

class SearchbarProvider extends ChangeNotifier {
  Apiservice api;
  String datasearch = "";
  String get data => datasearch;
  Status _datalistsearch = StatusIdle();
  Status get datalistsearch => _datalistsearch;
  SearchbarProvider({required this.api});

  void setdata(String data) {
    datasearch = data;
    notifyListeners();
  }

  void reset() {
    datasearch = "";
  }

  Future searchItem() async {
    _datalistsearch = Statusloading();
    try {
      if (datasearch == "") {
        _datalistsearch = StatusIdle();
        return;
      }
      final data = await api.getSearchRestoran(datasearch);
      if (data.founded < 1) {
        _datalistsearch = Statuserror(message: "tidak ada restoran yang cocok");
      } else if (data.error) {
        _datalistsearch = Statuserror(message: "terjadi ${data.error}");
      } else {
        _datalistsearch = StatussuksesSearch(datarestoran: data);
      }
    } on SocketException {
      _datalistsearch = Statuserror(
        message: "tidak ada koneksi silahkan coba lagi",
      );
    } catch (e) {
      _datalistsearch = Statuserror(message: "terjadi kesalahan $e");
    } finally {
      notifyListeners();
    }
  }
}
