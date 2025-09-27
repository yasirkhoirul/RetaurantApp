import 'package:flutter/material.dart';

class SearchbarProvider extends ChangeNotifier {
  String datasearch = "";

  String get data => datasearch;

  void setdata(String data) {
    datasearch = data;
    notifyListeners();
  }
}
