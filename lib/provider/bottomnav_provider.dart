import 'package:flutter/material.dart';

class Navigationprovider extends ChangeNotifier {
  int index = 0;
  int get indexNav => index;
  void setIndex(data) {
    index = data;
    notifyListeners();
  }
}
