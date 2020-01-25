import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_base/Database/DatabaseMarker.dart';


class FireMap extends StatefulWidget {
  FireMap();

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
      mapController.addListener((){
        if(REFRESH) {
          REFRESH = false;
          mapController.clearMarkers();
          _addMarkers(mapController);
        }
      });
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

  Future _addMarkers(GoogleMapController controller) async{
    DBMarkerHelper dbMarkerHelper = DBMarkerHelper.instance;
    List<MarkerData> markers = await dbMarkerHelper.getMarkers();
    var _icon =  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    for (int i = 0; i < markers.length; i++) {
      if(markers[i].active) {
        _icon =  BitmapDescriptor.defaultMarkerWithHue(
                     BitmapDescriptor.hueAzure);
      } else {
        _icon = BitmapDescriptor.defaultMarkerWithHue(
                   BitmapDescriptor.hueOrange);
      }
      var marker = MarkerOptions(
          position: LatLng(
              markers[i].latitude,
              markers[i].longitude),
              icon: _icon,
              infoWindowText: InfoWindowText(
                  markers[i].title,
                  markers[i].description)
      );
      controller.addMarker(marker);
    }
  }


}
