import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'color_provider/color_provider.dart';
import 'calendar_page.dart';
import 'color_selection_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ColorProvider(),
      child: MaterialApp(
        title: 'Colorful Calendar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        routes: {
          '/calendar': (context) => CalendarPage(),
          '/colorSelection': (context) => ColorSelectionPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              child: Text('Go to Calendar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/colorSelection');
              },
              child: Text('Set Colors'),
            ),
          ],
        ),
      ),
    );
  }
}
