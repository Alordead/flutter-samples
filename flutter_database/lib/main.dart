import 'package:flutter/material.dart';

final ThemeData kDefaultThemeData = ThemeData(
  primaryColor: Colors.redAccent,
  primarySwatch: Colors.red,
  primaryColorBrightness: Brightness.dark,
);

void main() => runApp(DBSampleApp());

class DBSampleApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Database Sample',
      theme: kDefaultThemeData,
      home: HomePage(title: "Flutter Database Sample",),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Hello flutter!"),
      ),
    );
  }
}
