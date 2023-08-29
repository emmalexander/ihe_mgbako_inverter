import 'dart:collection';
import 'package:math_expressions/math_expressions.dart';

import 'package:flutter/material.dart';

class UIProvider with ChangeNotifier {
  final List<String> _dropdownList = ['12', '24', '48', '96'];

  UnmodifiableListView<String> get getDropdownList {
    return UnmodifiableListView(_dropdownList);
  }

  String? _selectedItem;

  String? get getSelectedItem {
    return _selectedItem;
  }

  set selectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  double _backup = 0;
  double get getBackup => _backup;

  String calculateBackup(
      String load, String timeH, String timeM, String rating) {
    Parser p = Parser();
    Expression exp = p.parse('($load*($timeH+($timeM/60)))/$rating');
    ContextModel cm = ContextModel();
    double calculatedBackup = exp.evaluate(EvaluationType.REAL, cm);
    return calculatedBackup.toStringAsFixed(0);
  }
}
