import 'package:flutter/material.dart';
import 'todo_list_screen.dart';

final appTitle = "Simple To-Do list";

final kDefaultTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.blueAccent,
  scaffoldBackgroundColor: Colors.grey[100],
  primaryTextTheme: TextTheme(
      title: TextStyle(
        color: Colors.black,
        fontFamily: 'Gotham',
        fontSize: 26.0,
      ),
  ),
);

void main() {
  return runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: kDefaultTheme,
      home: ToDoListScreen(),
    );
  }
}