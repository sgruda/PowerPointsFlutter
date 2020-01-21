import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';

final String tableCoupons = 'coupons';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnIconImagePath = 'iconImagePath';
final String columnImagePath = 'imagePath';
final String columnPrice = 'price';
final String columnDescription = 'description';
final String columnIsBought = 'isBought';

class Coupon {
  int id;
  String title;
  String iconImagePath;
  String imagePath;
  int price;
  String description;
  bool  isBought;

  Coupon();

  Coupon.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    iconImagePath = map[columnIconImagePath];
    imagePath = map[imagePath];
    price = map[columnPrice];
    description = map[description];
    isBought = map[isBought];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnIconImagePath: iconImagePath,
      columnImagePath: imagePath,
      columnPrice: price,
      columnDescription: description,
      columnIsBought: isBought,
    };
    if (id != null){
      map[columnId] = id;
    }
    return map;
  }
}

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, 
        version: _databaseVersion,
        onCreate: _onCreate);
  }
  
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableCoupons (
                $columnId INTEGER PRIMARY KEY,
                $columnTitle TEXT NOT NULL,
                $columnIconImagePath TEXT NOT NULL,
                $columnImagePath TEXT NOT NULL,
                $columnPrice INTEGER NOT NULL,
                $columnDescription TEXT NOT NULL,
                $columnIsBought BIT NOT NULL
              )
              ''');
  }

  Future<int> insert(Coupon coupon) async {
    Database db = await database;
    int id = await db.insert(tableCoupons, coupon.toMap());
    return id;
  }

  Future<Coupon> queryCoupon(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
        tableCoupons,
        columns: [
          columnId,
          columnTitle,
          columnIconImagePath,
          columnImagePath,
          columnPrice,
          columnDescription,
          columnIsBought,
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Coupon.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return db.delete(tableCoupons, where: '$columnId = ?', whereArgs: [id]);
  }

  
}