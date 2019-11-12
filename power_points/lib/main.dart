import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'dart:async';

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
                CustomListTile(Icons.comment, 'Trivia', () {Navigator.push(context, MaterialPageRoute(builder: (context) => TriviaMenu()),);}),
                CustomListTile(Icons.settings, 'Settings', () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsMenu()),);}),
              ],
            ),
          ),

    );
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
        child:CircleAvatar(
          radius: 85,
          backgroundColor: Colors.deepOrange,
          child: CircleAvatar(
            radius: 75,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 100, color: Colors.grey,),
          )
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
        child: CircleAvatar(

        )
      ),
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
                target: LatLng(51.589496, 19.158193),                           // Home
//                target: LatLng(51.747300, 19.453670),                         // Polibuda
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
    _checkPoints();
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
//        position: LatLng(51.7474, 19.4537),                                       //Polibuda
        position: LatLng(51.58949, 19.15819),                                     //Home
        icon: BitmapDescriptor.defaultMarker,
        infoWindowText: InfoWindowText("Jej, udalo sie!","")
    );
    controller.addMarker(marker);
  }
  void _checkPoints() async {
    var location = new Location();
    var pos = await location.getLocation();
    if( abs(pos.latitude - 51.747 ) < 1 && abs(pos.longitude - 19.4537 ) < 1) {
      _neverSatisfied(context, "Brawo", "Udało Ci się!");
    }
  }
  double abs(double x) {
    return x < 0 ? -x : x;
  }
  Future<void> _neverSatisfied(BuildContext context, String title, String text) async {
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
}