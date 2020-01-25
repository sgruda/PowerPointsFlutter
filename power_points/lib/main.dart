import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/View/Menu.dart';
import 'package:flutter_base/View/CouponsMenu.dart';
import 'package:flutter_base/View/FireMapState.dart';
import 'package:flutter_base/Controller/CheckPointsFunction.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/Model/Constans.dart';
import 'package:flutter_base/Database/DatabaseMarker.dart';
import 'package:flutter_base/View/PointsMenu.dart';
import 'package:flutter_base/View/ProfileMenu.dart';
import 'package:flutter_base/View/DrawerTile.dart';

void main() => runApp(MyApp());



InputDecorationTheme inputDecorationTheme1 = InputDecorationTheme(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: color3,
    )
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: color3,
      )
  ),
  labelStyle: TextStyle(
    color: color5,
  )
);

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final newTextTheme = Theme.of(context).textTheme.apply(
      bodyColor: color5,
      displayColor: color5,
      decorationColor: color5,
    );
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        textTheme: newTextTheme,
        cursorColor: color4,
        primaryColor: color1,
        canvasColor: color2,
        scaffoldBackgroundColor: color2,
        splashColor: color3,
        accentColor: color3,
        cardColor: color3,
        buttonTheme: ButtonThemeData(
          buttonColor: color3,
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: color4),
        dialogBackgroundColor: color1,
        inputDecorationTheme: inputDecorationTheme1,
        iconTheme: IconThemeData(color: color5)
      ),
        home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBMarkerHelper dbHelper;

  Future<List<MarkerData>> markers;

  @override
  void initState() {
    super.initState();
    dbHelper = DBMarkerHelper();
    refreshMarkerList();
  }

  refreshMarkerList(){
    setState(() {
      markers = dbHelper.getMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FireMap(),
      appBar: AppBar(
        title: Text('PoliMapka'),
//        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Colors.deepOrange[500],
                      Colors.orange,
                    ])
                ),
                child: Container(
                  height: 40,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: color5,
                        radius: 45,
                        child: Icon(Icons.location_on, size: 90,color: Colors.blue[700]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('PoliMapka',style: TextStyle(color: Colors.white, fontSize: 30.0)),
                      ),
                    ],
                  ),
                )
            ),
            DrawerTile(Icons.person, 'Profil', () {Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileMenu()),);} ),
            DrawerTile(Icons.monetization_on, 'Punkty', () {Navigator.push(context, MaterialPageRoute(builder: (context) => PointsMenu()),);} ),
            DrawerTile(Icons.confirmation_number, 'Kupony', () {Navigator.push(context, MaterialPageRoute(builder: (context) => CouponsMenu()),);} ),
            DrawerTile(Icons.help_outline,'Pomoc', () {Navigator.push(context, MaterialPageRoute(builder: (context) => HelpMenu()),);} ),
            //DrawerTile(Icons.memory, 'Database', () {Navigator.push(context, MaterialPageRoute(builder: (context) => DataBaseMenu()),);} ),
         ],
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 200,
        child: FittedBox(
          child: FloatingActionButton.extended(
            label: Text("Sprawdź"),
            onPressed: ()
            {
              checkPoints(context);
            },
            icon: Icon(Icons.camera),
//            backgroundColor: Colors.deepOrange,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

