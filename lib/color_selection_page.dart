import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'color_provider/color_provider.dart';

class ColorSelectionPage extends StatelessWidget {
  final List<int> weekdays = [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
  ];

  final List<String> weekdayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Colors'),
      ),
      body: ListView.builder(
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(weekdayNames[index]),
            trailing: Container(
              width: 24,
              height: 24,
              color: colorProvider.dayColors[weekdays[index]],
            ),
            onTap: () {
              _pickColor(context, weekdays[index], colorProvider);
            },
          );
        },
      ),
    );
  }

  void _pickColor(BuildContext context, int weekday, ColorProvider colorProvider) {
    Color pickerColor = colorProvider.dayColors[weekday]!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color for ${weekdayNames[weekday - 1]}'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                pickerColor = color;
              },
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Select'),
              onPressed: () {
                colorProvider.setColorForDay(weekday, pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
