import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Database/DatabaseUsers.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';


final String tableCoupons = 'coupons';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnIconImagePath = 'iconImagePath';
final String columnImagePath = 'imagePath';
final String columnPrice = 'price';
final String columnDescription = 'description';
final String columnIsBought = 'isBought';



//Coupon('Piwo','assets/piwo_low.jpg', 'assets/piwo.jpg', 30, 'Kup jedno piwo w cenie dwóch i kolejne otrzymaj gratis! :0'),
//Coupon('Ukończenie studiów', 'assets/zaliczenie_low.jpg', 'assets/zaliczenie.jpg', 20, 'Pokaż rektorowi ten kupon i skończ studia wcześniej niż twoi rówieśnicy!'),
//Coupon('Zabieg dentystyczny', 'assets/slav.jpg', 'assets/slav.jpg', 30, 'Pokaż ten kupon dresowi, a otrzymasz darmowe prostowanie zębów.'),


class Coupon {
  int id;
  String title;
  String iconImagePath;
  String imagePath;
  int price;
  String description;
  bool  isBought;

  Coupon();


  buy(context) async{
    DBUsersHelper dbUsersHelper = DBUsersHelper.instance;
    User user = await getUser(1);
    if(user.points >= this.price && this.isBought == false){
      user.points -= this.price;
      updateUser(user);
      this.isBought = true;
      updateCoupon(this);
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Kupiono Kupon"),
            );
          }
      );
    }
    else{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Nie można kupić kuponu"),
            );
          }
      );
    }
  }

  Coupon.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    iconImagePath = map[columnIconImagePath];
    imagePath = map[columnImagePath];
    price = map[columnPrice];
    description = map[columnDescription];
    map[columnIsBought] == 0 ? isBought = false: isBought = true;
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

class DBCouponsHelper {
  DBCouponsHelper();

  static final _databaseName = "DatabaseCoupons.db";
  static final _databaseVersion = 1;

  DBCouponsHelper._privateConstructor();
  static final DBCouponsHelper instance = DBCouponsHelper._privateConstructor();

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
              CREATE TABLE $tableCoupons (
                $columnId INTEGER NOT NULL PRIMARY KEY,
                $columnTitle TEXT NOT NULL,
                $columnIconImagePath TEXT NOT NULL,
                $columnImagePath TEXT NOT NULL,
                $columnPrice INTEGER NOT NULL,
                $columnDescription TEXT NOT NULL,
                $columnIsBought BIT NOT NULL
              )
              ''');
  }

  Future<int> add(Coupon coupon) async {
    Database db = await database;
    int id = await db.insert(tableCoupons, coupon.toMap());
    return id;
  }

  Future<Coupon> getCoupon(int id) async {
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

  Future<List<Coupon>> getCoupons() async {
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
    );
    List<Coupon> coupons = [];
    if(maps.length > 0) {
      for(int i = 0; i < maps.length; i++) {
        coupons.add(Coupon.fromMap(maps[i]));
      }
    }
    return coupons;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      tableCoupons,
      where:  'id = ?',
      whereArgs: [id],
    );
  }

  Future deleteAll() async {
    Database db = await database;
    await db.delete(
      tableCoupons
    );
  }

  Future<int> update(Coupon coupon) async {
    Database db = await database;
    return await db.update(
      tableCoupons,
      coupon.toMap(),
      where: 'id = ?',
      whereArgs: [coupon.id],
    );
  }

  Future close() async{
    Database db = await database;
    db.close();
  }

}

getCoupon(id) async {
  DBCouponsHelper helper = DBCouponsHelper.instance;
  int rowId = id;
  Coupon coupon = await helper.getCoupon(rowId);
  if (coupon == null) {
    print('Coupon read row $rowId: empty');
  } else {
    print('Coupon read row $rowId: title: ${coupon.title}, iconImagePath: ${coupon.iconImagePath}, imagePath: ${coupon.imagePath}, price: ${coupon.price}, description: ${coupon.description}, isBought: ${coupon.isBought}');
    return coupon;
  }
}


addCoupon(title, iconImagePath, imagePath, price, description, isBought) async {
  Coupon coupon = Coupon();
  coupon.title = title;
  coupon.iconImagePath = iconImagePath;
  coupon.imagePath = imagePath;
  coupon.price = price;
  coupon.description = description;
  coupon.isBought = isBought;
  DBCouponsHelper helper = DBCouponsHelper.instance;
  int id = await helper.add(coupon);
  print('Coupon inserted row: $id');
}

deleteCoupon(int id) async {
  DBCouponsHelper helper = DBCouponsHelper.instance;
  int couponId = await helper.delete(id);
  print('Coupon deleted row: $couponId');
}

deleteAllCoupons() async {
  DBCouponsHelper helper = DBCouponsHelper.instance;
  await helper.deleteAll();
  print('Coupon deleted all coupons :<');
}

updateCoupon(coupon) async {
  DBCouponsHelper helper = DBCouponsHelper.instance;
  int couponId = await helper.update(coupon);
  print('Coupon updated row: $couponId');
}


