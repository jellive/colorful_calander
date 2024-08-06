import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'color_provider/color_provider.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<DateTime> _focusedDay;
  late final ValueNotifier<DateTime?> _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ValueNotifier(DateTime.now());
    _selectedDay = ValueNotifier(DateTime.now());
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay.value,
          selectedDayPredicate: (day) => isSameDay(_selectedDay.value, day),
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay.value, selectedDay)) {
              setState(() {
                _selectedDay.value = selectedDay;
                _focusedDay.value = focusedDay;
              });
            }
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorProvider.dayColors[day.weekday],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  day.day.toString(),
                  style: TextStyle().copyWith(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
