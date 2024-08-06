import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  Map<int, Color> _dayColors = {
    DateTime.monday: Colors.red,
    DateTime.tuesday: Colors.orange,
    DateTime.wednesday: Colors.yellow,
    DateTime.thursday: Colors.green,
    DateTime.friday: Colors.blue,
    DateTime.saturday: Colors.indigo,
    DateTime.sunday: Colors.purple,
  };

  Map<int, Color> get dayColors => _dayColors;

  void setColorForDay(int weekday, Color color) {
    _dayColors[weekday] = color;
    notifyListeners();
  }
}
