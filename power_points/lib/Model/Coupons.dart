import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';

List coupons = [
  Coupon('Piwo','assets/piwo_low.jpg', 'assets/piwo.jpg', 30, 'Kup jedno piwo w cenie dwóch i kolejne otrzymaj gratis! :0'),
  Coupon('Ukończenie studiów', 'assets/zaliczenie_low.jpg', 'assets/zaliczenie.jpg', 20, 'Pokaż rektorowi ten kupon i skończ studia wcześniej niż twoi rówieśnicy!'),
  Coupon('Zabieg dentystyczny', 'assets/slav.jpg', 'assets/slav.jpg', 30, 'Pokaż ten kupon dresowi, a otrzymasz darmowe prostowanie zębów.'),
];

class Coupon {
  String title;
  String iconImagePath;
  String imagePath;
  int price;
  String description;
  bool  isBought;

  Coupon(this.title, this.iconImagePath, this.imagePath, this.price, this.description){
    this.isBought = false;
  }

  buy(context) async{
    if(userPoints >= this.price && this.isBought == false){
      userPoints -= this.price;
      this.isBought = true;
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
}