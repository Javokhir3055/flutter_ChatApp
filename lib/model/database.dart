import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class User {
  final int id;
  final String sender;
  final String text;

  User({this.id, this.sender, this.text});
  Map<String, dynamic> toMap() => {
        'id': id,
        'sender': sender,
        'text': text,
      };
}

Future<Database> openDB() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'user.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE USERS(id INTEGER PRIMARY KEY,sender TEXT, text TEXT");
    },
    version: 1,
  );
  return database;
}

Future<void> insertUser(User user) async {
  final Database db = await openDB();
  await db.insert('USERS', user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, dynamic>>> readUsers() async {
  final Database db = await openDB();
  final List<Map<String, dynamic>> usersMap = await db.query('USERS');
  return List.generate(usersMap.length, (i) {
    
  });
}
