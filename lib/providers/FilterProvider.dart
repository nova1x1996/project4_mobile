import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  String search = "";

  void changeSearchContent(String value) {
    search = value;
    notifyListeners();
  }
}
