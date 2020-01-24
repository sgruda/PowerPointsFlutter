import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/View/Menu.dart';
import 'package:flutter_base/View/CouponsView.dart';
import 'package:flutter_base/View/FireMapState.dart';
import 'package:flutter_base/Controller/CheckPointsFunction.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/Model/Constans.dart';
import 'package:flutter_base/Database/DatabaseMarker.dart';

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
        title: Text('Mapka'),
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
                        child: Text('Mapka: The Game',style: TextStyle(color: Colors.white, fontSize: 25.0)),
                      ),
                    ],
                  ),
                )
            ),
            CustomListTile(Icons.person, 'Profile', () {Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileMenu()),);}),
            CustomListTile(Icons.monetization_on, 'Points', () {Navigator.push(context, MaterialPageRoute(builder: (context) => PointsMenu()),);}),
            CustomListTile(Icons.confirmation_number, 'Coupons', () {Navigator.push(context, MaterialPageRoute(builder: (context) => CouponsMenu()),);}),
            CustomListTile(Icons.memory, 'Database', () {Navigator.push(context, MaterialPageRoute(builder: (context) => DataBaseMenu()),);}),
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
            onPressed: ()
//            {
//              dbHelper.getMarkers().then((result) {
//                setState(() {
//                  markers = result.;
//                });
//              });
//            },




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

