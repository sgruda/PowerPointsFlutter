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
        home: Scaffold(
          body: FireMap()
        )
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
        position: LatLng(51.7474, 19.4537),
        icon: BitmapDescriptor.defaultMarker,
        infoWindowText: InfoWindowText("Jej, udalo sie!","")
    );
    controller.addMarker(marker);
  }
  void _checkPoints() async {
    var location = new Location();
    var pos = await location.getLocation();

    if( abs(pos.latitude - 51.747 ) < 0.001 && abs(pos.longitude - 19.4537 ) < 0.001) {

    }
    );
  }
  double abs(double x) {
    return x < 0 ? -x : x;
  }
}