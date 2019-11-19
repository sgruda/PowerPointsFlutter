import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'dart:async';

void main() => runApp(MyApp());

bool instruction = true;
int userPoints = 0;
String userName = "Jakobo Klepaczczo";

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
//            CustomListTile(Icons.comment, 'Trivia', () {Navigator.push(context, MaterialPageRoute(builder: (context) => TriviaMenu()),);}),
//            CustomListTile(Icons.settings, 'Settings', () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsMenu()),);}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _checkPoints(context);
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.deepOrange,
      )

    );
  }
}
double abs(double x) {
  return x < 0 ? -x : x;
}
Future<void> _popAd(BuildContext context, String title, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void _checkPoints(BuildContext context) async {
  var location = new Location();
  var pos = await location.getLocation();
  if(instruction) {
    _popAd(context, "Dziękujemy za pobranie aplikacji.", "Idź w świat i poznawaj kampus, przy okazji zbieraj punkty (klikając przy chodzeniu) i wymieniej je na piwo ;)");
    instruction = false;
  }
//  if(abs(pos.latitude - 51.589825 ) < 0.00012 && abs(pos.longitude - 19.158243 ) < 0.00012) {
//    _popAd(context, "Brawo", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
//  if( abs(pos.latitude - 51.590552 ) < 0.00052 && abs(pos.longitude - 19.158772 ) < 0.00052) {
//    _popAd(context, "Niemożliwe", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
//  if( abs(pos.latitude - 51.590969) < 0.00052 && abs(pos.longitude - 19.159729 ) < 0.00052) {
//    _popAd(context, "Zabka", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
//  if( abs(pos.latitude - 51.590459 ) < 0.00052 && abs(pos.longitude - 19.160708 ) < 0.00052) {
//    _popAd(context, "łaka", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
//  if( abs(pos.latitude - 51.589092 ) < 0.00052 && abs(pos.longitude - 19.158801 ) < 0.00052) {
//    _popAd(context, "Kotłownia", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
  if(abs(pos.latitude - 51.747179 ) < 0.00015 && abs(pos.longitude - 19.453392 ) < 0.00015) {
    _popAd(context, "Brawo", "Udało Ci się znaleźć windę. Zdobyłeś 10 punktów! Czy wiedziałeś, że często się psują?");
    userPoints += 10;
  }
  if( abs(pos.latitude - 51.747208 ) < 0.00015 && abs(pos.longitude - 19.453742 ) < 0.00015) {
    _popAd(context, "Niemożliwe", "Udało Ci się zobaczyć Lodex => budenek trzech wydziałów! Zdobyłeś 20 punktów!");
    userPoints += 10;
  }
  if( abs(pos.latitude - 51.747208) < 0.00015 && abs(pos.longitude - 19.453742 ) < 0.00015) {
    _popAd(context, "Kącik sali.", "Stoisz w kącie! Zdobyłeś 10 punktów!");
    userPoints += 10;
  }
}
class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Center(
              child:CircleAvatar(
                  radius: 85,
                  backgroundColor: Colors.deepOrange,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 100, color: Colors.grey,),
                  )
              ),
            ),
            SizedBox(height: 30,),
            Center(child: Text(userName, style: TextStyle(fontSize: 35),)),
          ],
        ),
        //child: Text("Morty",style: TextStyle(color: Colors.white,fontSize: 35),),
      ),
    );
  }
}



class PointsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Points"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("Number of points", style: TextStyle(fontSize: 35),)),
            SizedBox(height: 30,),
            Center(
                child:CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.deepOrange,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: Text(userPoints.toString(), style: TextStyle(fontSize: 50, color: Colors.black))),
              )
            )
          ],
        ),
      )
    );
  }
}

class TriviaMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trivia"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class SettingsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0,0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))
        ),
        child: InkWell(
            splashColor: Colors.grey,
            onTap: onTap,
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(text, style: TextStyle(
                              fontSize: 16.0
                          ),
                          ),
                        ),
                      ]
                  ),
                  Icon(Icons.arrow_right),
                ],
              ),
            )
        ),
      ),
    );
  }
}


class FireMap extends StatefulWidget {
  @override
  State createState() => FireMapState();
}

class FireMapState extends State<FireMap> {
  GoogleMapController mapController;
  build(context) {
    return Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
//                target: LatLng(51.589496, 19.158193),                           // Home
                target: LatLng(51.747300, 19.453670),                         // Polibuda
                zoom: 15
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            mapType: MapType.hybrid,
            compassEnabled: true,
          ),

        ]
    );
  }
  void _onMapCreated(GoogleMapController controller) {
    _addMarkers(controller);
    _animateToUser();
    //_checkPoints();
    setState(() {
      mapController = controller;
    });
  }
  _animateToUser() async {
    var location = new Location();
    var pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 17.0,
        )
    )
    );
  }
  void _addMarkers(GoogleMapController controller) {
    var marker = MarkerOptions(
        position: LatLng(51.747179, 19.453392),                                       //Polibuda
//        position: LatLng(51.589825, 19.158243),                                     //Home
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindowText: InfoWindowText("O winda!","")
    );
    controller.addMarker(marker);
    var marker2 = MarkerOptions(
        position: LatLng(51.747201, 19.452759),                                       //Polibuda
//        position: LatLng(51.590552, 19.158772),                                     //Home
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindowText: InfoWindowText("Kącik.","")
    );
    controller.addMarker(marker2);
    var marker3 = MarkerOptions(
        position: LatLng(51.747208, 19.453742),                                       //Polibuda
//        position: LatLng(51.590969, 19.159729),                                     //Home
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindowText: InfoWindowText("Lodex","")
    );
    controller.addMarker(marker3);

  }
//  void _checkPoints() async {
//    var location = new Location();
//    var pos = await location.getLocation();
//    if(instruction) {
//      setState(() {
//        _popAd(context, "Dziękujemy za pobranie aplikacji.", "Idź w świat i poznawaj kampus, przy okazji zbieraj punkty i wymieniej je na piwo ;)");
//      });
//      instruction = false;
//    }
//    if( abs(pos.latitude - 51.589825 ) < 0.00012 && abs(pos.longitude - 19.158243 ) < 0.00012) {
//      setState(() {
//        _popAd(context, "Brawo", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//    if( abs(pos.latitude - 51.590552 ) < 0.00052 && abs(pos.longitude - 19.158772 ) < 0.00052) {
//      setState(() {
//        _popAd(context, "Niemożliwe", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//    if( abs(pos.latitude - 51.590969) < 0.00052 && abs(pos.longitude - 19.159729 ) < 0.00052) {
//      setState(() {
//        _popAd(context, "Zabka", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//    if( abs(pos.latitude - 51.590459 ) < 0.00052 && abs(pos.longitude - 19.160708 ) < 0.00052) {
//      setState(() {
//        _popAd(context, "łaka", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//    if( abs(pos.latitude - 51.589092 ) < 0.00052 && abs(pos.longitude - 19.158801 ) < 0.00052) {
//      setState(() {
//        _popAd(context, "Kotłownia", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//
//  }
//  double abs(double x) {
//    return x < 0 ? -x : x;
//  }
//  Future<void> _popAd(BuildContext context, String title, String text) async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text(title),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                Text(text),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('OK'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
}