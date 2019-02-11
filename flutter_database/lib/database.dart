import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:path/path.dart';
import 'kana_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'TestDB.db');

    ByteData data = await rootBundle.load(join("assets", "TestDB.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);

    return openDatabase(path, readOnly: true);
  }

  newSign(Kana newClient) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Kana");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Kana (id,kana,reading)"
            " VALUES (?,?,?)",
        [id, newClient.kana, newClient.reading]);
    return raw;
  }

  updageSigns(Kana newClient) async {
    final db = await database;
    var res = await db.update("Kana", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getSign(int id) async {
    final db = await database;
    var res = await db.query("Kana", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Kana.fromMap(res.first) : null;
  }

  Future<List<Kana>> getAllSigns() async {
    final db = await database;
    var res = await db.query("Kana");
    print(res);

    List<Kana> list =
    res.isNotEmpty ? res.map((c) => Kana.fromMap(c)).toList() : [];

    return list;
  }

  deleteSign(int id) async {
    final db = await database;
    return db.delete("Kana", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Kana");
  }
}