import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

final String tableUsers = 'users';
final String columnId = 'id';
final String columnName = 'name';
final String columnPoints = 'points';


class User {
  int id;
  String name;
  int points;

  User();

  

  User.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    points = map[columnPoints];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnPoints: points,
    };
    if (id != null){
      map[columnId] = id;
    }
    return map;
  }
}

class DBUsersHelper {
  DBUsersHelper();

  static final _databaseName = "DatabaseUsers.db";
  static final _databaseVersion = 1;

  DBUsersHelper._privateConstructor();
  static final DBUsersHelper instance = DBUsersHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "database", _databaseName));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    return await openDatabase(
      path,
      readOnly: false,
      // version: _databaseVersion,
      // onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableUsers (
                $columnId INTEGER NOT NULL PRIMARY KEY,
                $columnName TEXT NOT NULL,
                $columnPoints INTEGER NOT NULL
              )
              ''');
  }

  Future<int> add(User user) async {
    Database db = await database;
    int id = await db.insert(tableUsers, user.toMap());
    return id;
  }

  Future<User> getUser(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
        tableUsers,
        columns: [
          columnId,
          columnName,
          columnPoints,
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<List<User>> getUsers() async {
    Database db = await database;
    List<Map> maps = await db.query(
      tableUsers,
      columns: [
        columnId,
        columnName,
        columnPoints,
      ],
    );
    List<User> users = [];
    if(maps.length > 0) {
      for(int i = 0; i < maps.length; i++) {
        users.add(User.fromMap(maps[i]));
      }
    }
    return users;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      tableUsers,
      where:  'id = ?',
      whereArgs: [id],
    );
  }

  Future deleteAll() async {
    Database db = await database;
    await db.delete(
        tableUsers
    );
  }

  Future<int> update(User user) async {
    Database db = await database;
    return await db.update(
      tableUsers,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future close() async{
    Database db = await database;
    db.close();
  }

}

getUser(id) async {
  DBUsersHelper helper = DBUsersHelper.instance;
  int rowId = id;
  User user = await helper.getUser(rowId);
  if (user == null) {
    print('User read row $rowId: empty');
  } else {
    print('User read row $rowId: name: ${user.name}, points: ${user.points}');
    return user;
  }
}



addUser(name, points) async {
  User user = User();
  user.name = name;
  user.points = points;
  DBUsersHelper helper = DBUsersHelper.instance;
  int id = await helper.add(user);
  print('User inserted row: $id');
}

deleteUser(int id) async {
  DBUsersHelper helper = DBUsersHelper.instance;
  int userId = await helper.delete(id);
  print('User deleted row: $userId');
}

deleteAllUsers() async {
  DBUsersHelper helper = DBUsersHelper.instance;
  await helper.deleteAll();
  print('User deleted all users :<');
}

updateUser(User user) async {
  DBUsersHelper helper = DBUsersHelper.instance;
  int userId = await helper.update(user);
  print('User updated row: $userId');
}

changeNameUser(int id, String newName) async{
  DBUsersHelper helper = DBUsersHelper.instance;
  User user = await helper.getUser(id);
  user.name = newName;
  int userId = await helper.update(user);
  print('User updated row: $userId');
}

