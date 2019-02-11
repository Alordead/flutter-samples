import 'package:flutter/material.dart';
import 'database.dart';
import 'kana_model.dart';

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
      body: FutureBuilder<List<Kana>>(
        future: DBProvider.db.getAllSigns(),
        builder: (BuildContext context, AsyncSnapshot<List<Kana>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
               itemBuilder: (BuildContext context, int index) {
                Kana item = snapshot.data[index];
                return ListTile(
                  title: Text(item.kana),
                  subtitle: Text(item.reading),
                  leading: Text(item.id.toString()),
                  );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
