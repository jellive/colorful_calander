import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colorful Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Colorful Calendar'),

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
                  color: _getColorForDay(day),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Text(day.day.toString(),
                style: TextStyle().copyWith(color: Colors.white))
              );
            }
          )
        )
      )
    );
  }

  Color _getColorForDay(DateTime day) {
    switch (day.weekday) {
      case DateTime.monday:
        return Colors.red;
      case DateTime.tuesday:
        return Colors.orange;
      case DateTime.wednesday:
        return Colors.yellow;
      case DateTime.thursday:
        return Colors.green;
      case DateTime.friday:
        return Colors.blue;
      case DateTime.saturday:
        return Colors.indigo;
      case DateTime.sunday:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
