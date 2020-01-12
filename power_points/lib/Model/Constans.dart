import 'dart:io';
import 'package:flutter_base/View/Coupons.dart';

bool instruction = true;
int userPoints = 60;
String userName = "Anonim";
bool REFRESH = false;
File imageFile;

List coupons = [
  Coupon('Piwo','assets/piwo_low.jpg', 'assets/piwo.jpg', 30, 'Kup jedno piwo w cenie dwóch i kolejne otrzymaj gratis! :0'),
  Coupon('Ukończenie studiów', 'assets/zaliczenie_low.jpg', 'assets/zaliczenie.jpg', 20, 'Pokaż rektorowi ten kupon i skończ studia wcześniej niż twoi rówieśnicy!'),
  Coupon('Zabieg dentystyczny', 'assets/slav.jpg', 'assets/slav.jpg', 30, 'Pokaż ten kupon dresowi, a otrzymasz darmowe prostowanie zębów.'),
];

