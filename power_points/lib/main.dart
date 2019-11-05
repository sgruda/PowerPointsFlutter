import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'dart:async';

void main() => runApp(MyApp());

CurrentLocation cur = new CurrentLocation();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: FireMap()
        )
      // body: Center(
      //    child: Text('Hello World'),
      //   ),
       //)
    );
  }
}

class FireMap extends StatefulWidget {
  @override
  State createState() => FireMapState();
}

class CurrentLocation {
  double latitude;
  double longitude;

  _getLocation() async {
    var location = new Location();
    try {
      var currentLocation = await location.getLocation();
      latitude = currentLocation["latitude"];
      longitude = currentLocation["longitude"];
    } on Exception {
        latitude = 0;
        longitude = 0;
    }
  }
  double getLatitude() {
    _getLocation();
    return latitude;
  }
  double getLongitude() {
    _getLocation();
    return longitude;
  }
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
                //target: LatLng(currentLocation['latitude'], currentLocation['longitude']),
                zoom: 15
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            mapType: MapType.hybrid,
            compassEnabled: true,
            trackCameraPosition: true,
          ),

        ]
    );
  }
  void _onMapCreated(GoogleMapController controller) {
//    _getLocation();
    _animateToUser();
    setState(() {
      mapController = controller;
    });
  }
  _animateToUser() async {
//    var location = new Location();
//    var pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(cur.getLatitude(), cur.getLongitude()),
//          target: LatLng(pos["latitude"], pos["longitude"]),
          zoom: 17.0,
        )
    )
    );
  }
}