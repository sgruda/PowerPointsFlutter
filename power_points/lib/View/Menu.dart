import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Database/DatabaseMarker.dart';
import 'package:flutter_base/Database/DatabaseCoupon.dart';
import 'package:flutter_base/Database/DatabaseUsers.dart';
import 'package:flutter_base/Model/Constans.dart';

class HelpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Help"),
//          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: Container(
            child: Text('Placeholder'),
          )
        )
    );
  }
}


class DataBaseMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Database"),
//          backgroundColor: Colors.deepOrange,
        ),
      body: Column(
        children: <Widget>[
          Text("Coupons"),
          Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read'),
                  onPressed: () {
                    getCoupon(1);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    addCoupon('Piwo','assets/piwo_low.jpg', 'assets/piwo.jpg', 30, 'Kup jedno piwo w cenie dwóch i kolejne otrzymaj gratis! :0', false);
                    addCoupon('Ukończenie studiów', 'assets/zaliczenie_low.jpg', 'assets/zaliczenie.jpg', 20, 'Pokaż rektorowi ten kupon i skończ studia wcześniej niż twoi rówieśnicy!', false);
                    addCoupon('Zabieg dentystyczny', 'assets/slav.jpg', 'assets/slav.jpg', 30, 'Pokaż ten kupon dresowi, a otrzymasz darmowe prostowanie zębów.', false);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Delete all'),
                  onPressed: () {
                    deleteAllCoupons();
                  },
                ),
              ),
            ],
          ),
          Text("Markers"),
          Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read'),
                  onPressed: () {
                    getMarker(5);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    addMarker(
                        51.747179, 19.453392,
                        "O winda!", "",
                        "Brawo", "Udało Ci się znaleźć windę. Zdobyłeś 10 punktów! Czy wiedziałeś, że często się psują?",
                        10, true);
                    addMarker(
                        51.747208, 19.453742,
                        "Lodex", "",
                        "Niemożliwe", "Udało Ci się zobaczyć Lodex => budenek trzech wydziałów! Zdobyłeś 20 punktów!",
                        10, true);
                    addMarker(
                        51.747208, 19.453742,
                        "Kącik.", "",
                        "Kącik sali.", "Stoisz w kącie! Zdobyłeś 10 punktów!",
                        10, true);
                    addMarker(
                        51.589825, 19.158179,
                        "blok.", "",
                        "dgsg", "Stoisz w kącie! Zdobyłeś 10 punktów!",
                        10, true);
                    addMarker(
                        51.755231, 19.530784,
                        "Klepek", "",
                        "Dom Klepka", "Przystań Bogów",
                        100, true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Delete all'),
                  onPressed: () {
                    deleteAllMarker();
                  },
                ),
              ),
            ],
          ),
          Text("User"),
          Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read'),
                  onPressed: () {
                    getUser(1);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    addUser('Klepek', 100);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Delete all'),
                  onPressed: () {
                    deleteAllUsers();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

