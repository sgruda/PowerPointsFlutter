import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/View/Menu.dart';
import 'package:flutter_base/View/Coupons.dart';
import 'package:flutter_base/View/FireMapState.dart';
import 'package:flutter_base/Controller/CheckPointsFunction.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    precacheImage(AssetImage("assets/piwo.jpg"), context);
    precacheImage(AssetImage("assets/zaliczenie.jpg"), context);
    precacheImage(AssetImage("assets/slav.jpg"), context);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
        home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FireMap(),
      appBar: AppBar(
        title: Text('Mapka'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Colors.deepOrange[500],
                      Colors.orange
                    ])
                ),
                child: Container(
                  height: 40,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        child: Icon(Icons.location_on, size: 90,color: Colors.blue,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Mapka: The Game',style: TextStyle(color: Colors.white, fontSize: 25.0)),
                      ),
                    ],
                  ),
                )
            ),
            CustomListTile(Icons.person, 'Profile', () {Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileMenu()),);}),
            CustomListTile(Icons.monetization_on, 'Points', () {Navigator.push(context, MaterialPageRoute(builder: (context) => PointsMenu()),);}),
            CustomListTile(Icons.confirmation_number, 'Coupons', () {Navigator.push(context, MaterialPageRoute(builder: (context) => CouponsMenu()),);}),
//            CustomListTile(Icons.comment, 'Trivia', () {Navigator.push(context, MaterialPageRoute(builder: (context) => TriviaMenu()),);}),
//            CustomListTile(Icons.settings, 'Settings', () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsMenu()),);}),
            CustomListTile(Icons.comment, 'QRCodeTest', () {Navigator.push(context, MaterialPageRoute(builder: (context) => QRCodeTest()),);}),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 200,
        child: FittedBox(
          child: FloatingActionButton.extended(
            label: Text("Sprawdź"),
            onPressed: () {
              checkPoints(context);
            },
            icon: Icon(Icons.camera),
            backgroundColor: Colors.deepOrange,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

