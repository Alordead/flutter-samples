import 'package:flutter/material.dart';

final kDefaultTheme = ThemeData(
  primarySwatch: Colors.green,
  accentColor: Colors.greenAccent,
);

void main() {
  return runApp( ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-do list',
      theme: kDefaultTheme,
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  State createState() => ToDoListScreenState();
}

class ToDoListScreenState extends State<ToDoListScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text('Hello!'),
              )
            ],
          ),
        ),
      ),
    );
  }
}