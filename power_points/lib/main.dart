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
          body: FireMap(),
//          appBar: AppBar(
//            title: Text('Latitude: ' + cur.getLatitude().toString() + '\nLongitude: ' + cur.getLongitude().toString()),
//          ),

        )
      // body: Center(
      //    child: Text('Hello World'),
      //   ),
      // )
    );
  }
}

class FireMap extends StatefulWidget {
  @override
//  CurrentLocation location;
//  FireMap(CurrentLocation currentLocation) {
//    location = currentLocation;
//  }
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
  String lat = "loading";
  String long = "loading";
  build(context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Latitude: ' + lat + '\nLongitude: ' + long),
    ),
        body: Container(
        child: Stack(
           children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
//                target: LatLng(51.589496, 19.158193),
                target: LatLng(51.747300, 19.453670),
                //target: LatLng(currentLocation['latitude'], currentLocation['longitude']),
                zoom: 15
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            mapType: MapType.hybrid,
            compassEnabled: true,
            trackCameraPosition: true,
          ),

        ]))
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
    var location = new Location();
    var pos = await location.getLocation();
  lat = cur.getLatitude().toString();
  long = cur.getLongitude().toString();

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(cur.getLatitude(), cur.getLongitude()),
          zoom: 17.0,
        )
    )
    );
  print("lat = " +cur.getLatitude().toString());
  print("long = " + cur.getLongitude().toString());
    print("lat pos = " +pos["latitude"].toString());
    print("long pos = " + pos["longitude"].toString());
  }
}