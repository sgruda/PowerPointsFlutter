import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_base/Database/DatabaseHelpers.dart';

read(id) async {
  DatabaseHelper helper = DatabaseHelper.instance;
  int rowId = id;
  Coupon coupon = await helper.queryCoupon(rowId);
  if (coupon == null) {
    print('read row $rowId: empty');
  } else {
    print('read row $rowId: title: ${coupon.title}, iconImagePath: ${coupon.iconImagePath}, imagePath: ${coupon.imagePath}, price: ${coupon.price}, description: ${coupon.description}, isBought ${coupon.isBought}');
  }
}


save(title, iconImagePath, imagePath, price, description, isBought) async {
  Coupon coupon = Coupon();
  coupon.title = title;
  coupon.iconImagePath = iconImagePath;
  coupon.imagePath = imagePath;
  coupon.price = price;
  coupon.description = description;
  coupon.isBought = isBought;
  DatabaseHelper helper = DatabaseHelper.instance;
  int id = await helper.insert(coupon);
  print('inserted row: $id');
}

delete(int id) async {
  delete(id);
}