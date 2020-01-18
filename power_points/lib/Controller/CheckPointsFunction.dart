import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter_base/Model/Constans.dart';
import 'package:flutter_base/Model/Markers.dart';
import 'package:shared_preferences/shared_preferences.dart';


void checkPoints(BuildContext context) async {
  var location = new Location();
  var pos = await location.getLocation();
  if(instruction) {
    _popAd(context, "Dziękujemy za pobranie aplikacji.", "Idź w świat i poznawaj kampus, przy okazji zbieraj punkty (klikając przy chodzeniu) i wymieniej je na piwo ;)");
    instruction = false;
  }
  for(int i = 0 ; i < Markers.markers.length; i++) {
    Markers.load();
    if (Markers.markers[i].active &&
        abs(pos.latitude - Markers.markers[i].markerLatitude) < 0.00015 &&
        abs(pos.longitude - Markers.markers[i].markerLongitude) < 0.00015) {

      _popAd(context, Markers.markers[i].markerTitleAfterCheck,
              Markers.markers[i].markerDescriptionAfterCheck);
      userPoints += Markers.markers[i].points;
      Markers.markers[i].active = false;
      _activeMarkerSave(i.toString(), false);
      REFRESH = true;
    }
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
_activeMarkerSave(markerIndex, active) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("activeMarker" + markerIndex, active);
  print('$markerIndex  $active');

}