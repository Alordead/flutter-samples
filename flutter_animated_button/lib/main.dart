import 'package:flutter/material.dart';

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.blueAccent,
);

void main() => runApp(ButtonAnimationsApp());

class ButtonAnimationsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kDefaultTheme,
      home: ButtonAnimationsScreen(),
    );
  }
}

class ButtonAnimationsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }
}

