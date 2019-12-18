import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/View/Menu.dart';
import 'package:flutter_base/View/Coupons.dart';
import 'package:flutter_base/View/FireMapState.dart';
import 'package:flutter_base/Controller/CheckPointsFunction.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: Icon(Icons.location_on, size: 100,color: Colors.blue,),
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

