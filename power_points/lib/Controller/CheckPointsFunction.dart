import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter_base/Model/Constans.dart';
import 'package:flutter_base/Database/DatabaseMarker.dart';
import 'package:flutter_base/Database/DatabaseUsers.dart';

Future checkPoints(BuildContext context) async {
  DBMarkerHelper dbMarkerHelper = DBMarkerHelper.instance;
  List<MarkerData> markers = await dbMarkerHelper.getMarkers();
  
  DBUsersHelper dbUsersHelper = DBUsersHelper.instance;
  User user = await dbUsersHelper.getUser(1);
  
  var location = new Location();
  var pos = await location.getLocation();
  if(instruction) {
    _popAd(context, "Dziękujemy za pobranie aplikacji.", "Idź w świat i poznawaj kampus, przy okazji zbieraj punkty (klikając przy chodzeniu) i wymieniej je na piwo ;)");
    instruction = false;
  }
  for(int i = 0 ; i < markers.length; i++) {
    if (markers[i].active &&
        abs(pos.latitude - markers[i].latitude) < 0.00015 &&
        abs(pos.longitude - markers[i].longitude) < 0.00015) {

      _popAd(context, markers[i].titleAfterCheck,
              markers[i].descriptionAfterCheck);
      user.points += markers[i].points;
      updateUser(user);
      markers[i].active = false;
      markers[i].points = 200;
      await updateMarker(markers[i]);
      print('Marker ${markers[i].id} ${markers[i].active.toString()}');
      getMarker(i+1);
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