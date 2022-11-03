import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lang AlarmV1',
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
              label: "Sleep", icon: Icon(Icons.mode_night_outlined)),
          BottomNavigationBarItem(label: "Lang", icon: Icon(Icons.abc)),
          BottomNavigationBarItem(label: "Settings", icon: Icon(Icons.settings))
        ]),
      ),
    );
  }
}
