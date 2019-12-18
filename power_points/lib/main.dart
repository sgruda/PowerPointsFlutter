import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'Model/Markers.dart';
import 'Model/Constans.dart';
import 'package:flutter_base/View/Menu.dart';
import 'package:flutter_base/View/Coupons.dart';

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
              _checkPoints(context);
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
  for(int i = 0 ; i < Markers.markers.length; i++) {
    if (abs(pos.latitude - Markers.markers[i].markerLatitude) < 0.00015 &&
        abs(pos.longitude - Markers.markers[i].markerLongitude) < 0.00015) {
      _popAd(context, Markers.markers[i].markerTitleAfterCheck,
          Markers.markers[i].markerDescriptionAfterCheck);
      userPoints += Markers.markers[i].points;
    }
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
    for(int i = 0 ; i < Markers.markers.length; i++) {
      var marker = MarkerOptions(
          position: LatLng(Markers.markers[i].markerLatitude, Markers.markers[i].markerLongitude),                                       //Polibuda
//        position: LatLng(51.589825, 19.158243),                                     //Home
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindowText: InfoWindowText(Markers.markers[i].markerTitle, Markers.markers[i].markerDescription)
      );
      controller.addMarker(marker);
    }
  }
}