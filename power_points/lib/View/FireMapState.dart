import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_base/Model/Markers.dart';

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
                target: LatLng(51.747300, 19.453670), // Polibuda
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
    for (int i = 0; i < Markers.markers.length; i++) {
      var marker = MarkerOptions(
          position: LatLng(Markers.markers[i].markerLatitude,
              Markers.markers[i].markerLongitude),
          //Polibuda
//        position: LatLng(51.589825, 19.158243),                                     //Home
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure),
          infoWindowText: InfoWindowText(Markers.markers[i].markerTitle,
              Markers.markers[i].markerDescription)
      );
      controller.addMarker(marker);
    }
  }
}