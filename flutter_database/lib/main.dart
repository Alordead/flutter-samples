import 'package:flutter/material.dart';
import 'database.dart';
import 'kana_model.dart';

final ThemeData kDefaultThemeData = ThemeData(
  primaryColor: Colors.blueGrey,
  primarySwatch: Colors.grey,
  brightness: Brightness.dark,
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
      body: FutureBuilder<List<Kana>>(
        future: DBProvider.db.getAllSigns(),
        builder: (BuildContext context, AsyncSnapshot<List<Kana>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemBuilder: (context, position) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data[position].kana, style: TextStyle(fontSize: 32.0),),
                      Text(snapshot.data[position].reading),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
