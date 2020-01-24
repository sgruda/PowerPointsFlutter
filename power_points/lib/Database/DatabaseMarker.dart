import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';

final String tableMarkers = 'markers';
final String columnId = 'id';
final String columnLatitude = 'latitude';
final String columnLongitude = 'longitude';
final String columnTitle = 'title';
final String columnDescription = 'descritption';
final String columnTitleAfterCheck = 'titleAfterCheck';
final String columnDescriptionAfterCheck = 'descriptionAfterCheck';
final String columnPoints = 'points';
final String columnActive = 'active';


class MarkerData {
  int id;
  double latitude;
  double longitude;
  String title;
  String description;
  String titleAfterCheck;
  String descriptionAfterCheck;
  int points;
  bool active;

  MarkerData();

  MarkerData.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    latitude = map[columnLatitude];
    longitude = map[columnLongitude];
    title = map[columnTitle];
    description = map[columnDescription];
    titleAfterCheck = map[columnTitleAfterCheck];
    descriptionAfterCheck = map[columnDescriptionAfterCheck];
    points = map[columnPoints];
    active = map[columnActive] == 0 ? active = false : active = true;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnLatitude: latitude,
      columnLongitude: longitude,
      columnTitle: title,
      columnDescription: description,
      columnTitleAfterCheck: titleAfterCheck,
      columnDescriptionAfterCheck: descriptionAfterCheck,
      columnPoints: points,
      columnActive: active,
    };
    if (id != null){
      map[columnId] = id;
    }
    return map;
  }
}

class DBMarkerHelper {
  DBMarkerHelper();

  static final _databaseName = "DatabaseMarkers.db";
  static final _databaseVersion = 1;

  DBMarkerHelper._privateConstructor();
  static final DBMarkerHelper instance = DBMarkerHelper._privateConstructor();

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
              CREATE TABLE $tableMarkers (
                $columnId INTEGER PRIMARY KEY,
                $columnLatitude DOUBLE NOT NULL,
                $columnLongitude DOUBLE NOT NULL,
                $columnTitle TEXT NOT NULL,
                $columnDescription TEXT NOT NULL,
                $columnTitleAfterCheck TEXT NOT NULL,
                $columnDescriptionAfterCheck TEXT NOT NULL,
                $columnPoints INTEGER NOT NULL,
                $columnActive BIT NOT NULL
              )
              ''');
  }

  Future<int> add(MarkerData marker) async {
    Database db = await database;
    int id = await db.insert(tableMarkers, marker.toMap());
    return id;
  }

  Future<MarkerData> getMarker(int id) async{
    Database db = await database;
    List<Map> maps = await db.query(
        tableMarkers,
        columns: [
          columnId,
          columnLatitude,
          columnLongitude,
          columnTitle,
          columnDescription,
          columnTitleAfterCheck,
          columnDescriptionAfterCheck,
          columnPoints,
          columnActive,
        ],
      where: "$columnId = ?",
      whereArgs: [id]);
    if (maps.length > 0) {
      return MarkerData.fromMap(maps.first);
    }
    return null;
  }

  Future<List<MarkerData>> getMarkers() async{
    Database db = await database;
    List<Map> maps = await db.query(
      tableMarkers,
      columns: [
        columnId,
        columnLatitude,
        columnLongitude,
        columnTitle,
        columnDescription,
        columnTitleAfterCheck,
        columnDescriptionAfterCheck,
        columnPoints,
        columnActive,
      ],
    );
    List<MarkerData> markers = [];
    if(maps.length > 0) {
      for(int i = 0; i < maps.length; i++) {
        markers.add(MarkerData.fromMap(maps[i]));
      }
    }
    return markers;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      tableMarkers,
      where:  'id = ?',
      whereArgs: [id],
    );
  }

  Future deleteAll() async{
    Database db = await database;
    await db.delete(
      tableMarkers
    );
  }

  Future<int> update(MarkerData marker) async {
    Database db = await database;
    print('In method update     ${marker.id.toString()}   ${marker.active.toString()} ');
    return await db.update(
      tableMarkers,
      marker.toMap(),
      where: 'id = ?',
      whereArgs: [marker.id],
    );
  }

}

getMarker(id) async {
  DBMarkerHelper helper = DBMarkerHelper.instance;
  int rowId = id;
  MarkerData marker = await helper.getMarker(rowId);
  if (marker == null) {
    print('Marker read row $rowId: empty');
  } else {
    print('Marker read row $rowId: latitude: ${marker.latitude}, langitude: ${marker.longitude}, title: ${marker.title}, description: ${marker.description}, titleAfterCheck: ${marker.titleAfterCheck}, titleDescriptionCheck: ${marker.descriptionAfterCheck}, points: ${marker.points}, active: ${marker.active}  ');
  }
}



addMarker(latitude, longitude, title, description, titleAfterCheck, descriptionAfterCheck, points, active) async {
  MarkerData marker = MarkerData();
  marker.latitude = latitude;
  marker.longitude = longitude;
  marker.title = title;
  marker.description = description;
  marker.titleAfterCheck = titleAfterCheck;
  marker.descriptionAfterCheck = descriptionAfterCheck;
  marker.points = points;
  marker.active = active;
  DBMarkerHelper helper = DBMarkerHelper.instance;
  int id = await helper.add(marker);
  print('Marker inserted row: $id');
}

deleteMarker(int id) async {
  DBMarkerHelper helper = DBMarkerHelper.instance;
  int markerId = await helper.delete(id);
  print('Marker deleted ro: $markerId');
}

deleteAllMarker() async {
  DBMarkerHelper helper = DBMarkerHelper.instance;
  await helper.deleteAll();
  print('Marker deleted all markers :(');
}

updateMarker(MarkerData marker) async {
  DBMarkerHelper helper = DBMarkerHelper.instance;
  await helper.update(marker);
  print('Marker updated row: ${marker.id.toString()}');
}




