import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: FireMap()
          //body: Center(
         //   child: Text('Hello World'),
         // ),
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
              initialCameraPosition: CameraPosition(target: LatLng(24.150, -110.32), zoom: 10),
          ),
        ]
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}