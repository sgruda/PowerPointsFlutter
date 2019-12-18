import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'dart:async';
import 'Markers.dart';

void main() => runApp(MyApp());

bool instruction = true;
int userPoints = 0;
String userName = "Jakubo Klepaczoo";

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
//  if(abs(pos.latitude - 51.589825 ) < 0.00012 && abs(pos.longitude - 19.158243 ) < 0.00012) {
//    _popAd(context, "Brawo", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
//  if( abs(pos.latitude - 51.590552 ) < 0.00052 && abs(pos.longitude - 19.158772 ) < 0.00052) {
//    _popAd(context, "Niemożliwe", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
//  if( abs(pos.latitude - 51.590969) < 0.00052 && abs(pos.longitude - 19.159729 ) < 0.00052) {
//    _popAd(context, "Zabka", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
//  if( abs(pos.latitude - 51.590459 ) < 0.00052 && abs(pos.longitude - 19.160708 ) < 0.00052) {
//    _popAd(context, "łaka", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
//  if( abs(pos.latitude - 51.589092 ) < 0.00052 && abs(pos.longitude - 19.158801 ) < 0.00052) {
//    _popAd(context, "Kotłownia", "Udało Ci się! Zdobyłeś 100 punktów!");
//    userPoints += 100;
//  }
  /*if(abs(pos.latitude - Markers.markers["1"].markerLatitude ) < 0.00015 && abs(pos.longitude - Markers.markers["1"].markerLongitude ) < 0.00015) {
    _popAd(context, Markers.markers["1"].markerTitleAfterCheck, Markers.markers["1"].markerDescriptionAfterCheck);
    userPoints += Markers.markers["1"].points;
  }
  if( abs(pos.latitude - 51.747208 ) < 0.00015 && abs(pos.longitude - 19.453742 ) < 0.00015) {
    _popAd(context, "Niemożliwe", "Udało Ci się zobaczyć Lodex => budenek trzech wydziałów! Zdobyłeś 20 punktów!");
    userPoints += 10;
  }
  if( abs(pos.latitude - 51.747208) < 0.00015 && abs(pos.longitude - 19.453742 ) < 0.00015) {
    _popAd(context, "Kącik sali.", "Stoisz w kącie! Zdobyłeś 10 punktów!");
    userPoints += 10;
  }*/
  for(int i = 0 ; i < Markers.markers.length; i++) {
    if (abs(pos.latitude - Markers.markers[i].markerLatitude) < 0.00015 &&
        abs(pos.longitude - Markers.markers[i].markerLongitude) < 0.00015) {
      _popAd(context, Markers.markers[i].markerTitleAfterCheck,
          Markers.markers[i].markerDescriptionAfterCheck);
      userPoints += Markers.markers[i].points;
    }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Center(
              child:CircleAvatar(
                  radius: 85,
                  backgroundColor: Colors.deepOrange,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 100, color: Colors.grey,),
                  )
              ),
            ),
            SizedBox(height: 30,),
            Center(child: Text(userName, style: TextStyle(fontSize: 35),)),
          ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: Text("Number of points", style: TextStyle(fontSize: 35),)),
              SizedBox(height: 30,),
              Center(
                  child:CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.deepOrange,
                    child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: Text(userPoints.toString(), style: TextStyle(fontSize: 50, color: Colors.black))),
                  )
              )
            ],
          ),
        )
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

class CouponsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupons"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Container(
          child: _myListView(context),

        ),
      ),
    );
  }
}

class CouponMenu extends StatelessWidget {
  Coupon coupon;

  CouponMenu(this.coupon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            getBackground(),
            getGradient(),
            getContent(),
            getToolbar(context),
          ],
        ),
      ),
    );
  }
  Container getBackground() {
    return new Container(
      child: new Image.asset(
        coupon.imagePath,
        fit: BoxFit.cover,
        height: 300.0,
      ),
     constraints: new BoxConstraints.expand(height: 300.0),
    );
  }
  Container getGradient() {
    return Container(
      margin:  EdgeInsets.only(top: 190.0),
      height: 200.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.transparent,
            Colors.white,
        ],
            stops:  [0.0, 0.5],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 0.9),
        ),
      ),
    );
  }
  Widget getContent(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
          child: Center(
            child: Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "Kup",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Container(
            child: Text(
              coupon.title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20)

            ),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                    coupon.description,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            )
          ),
        )
      ],
    );
  }
}

Container getToolbar(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      top: MediaQuery
          .of(context)
          .padding
          .top),
    child: BackButton(color: Colors.white,),
  );
}



class Coupon {
  String title;
  String imagePath;
  int price;
  String description;

  Coupon(this.title, this.imagePath, this.price, this.description);
}

Widget _myListView(BuildContext context) {

  final coupons = [
    Coupon('Piwo', 'assets/piwo.jpg', 30, 'Kup dwa piwa w cenie jednego i kolejne otrzymaj gratis! :0'),
    Coupon('Ukończenie studiów', 'assets/zaliczenie.jpg', 20, 'Pokaż rektorowi ten kupon i skończ studia wcześniej niż twoi rówieśnicy! AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
    Coupon('Zabieg dentystyczny', 'assets/slav.jpg', 30, 'Pokaż ten kupon dresowi, a otrzymasz darmowe prostowanie zębów.')
  ];

  return ListView.builder(
    itemCount: coupons.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(coupons[index].imagePath),
          ),
          title: Text(coupons[index].title),
          subtitle: Text("Cena: " + coupons[index].price.toString()),
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CouponMenu(coupons[index])),);},
        ),
      );
    },
  );

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
/*    var marker = MarkerOptions(
        position: LatLng(Markers.markers["1"].markerLatitude, Markers.markers["1"].markerLongitude),                                       //Polibuda
//        position: LatLng(51.589825, 19.158243),                                     //Home
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindowText: InfoWindowText(Markers.markers["1"].markerTitle, Markers.markers["1"].markerDescription)
    );
    controller.addMarker(marker);
    var marker2 = MarkerOptions(
        position: LatLng(51.747201, 19.452759),                                       //Polibuda
//        position: LatLng(51.590552, 19.158772),                                     //Home
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindowText: InfoWindowText("Kącik.","")
    );
    controller.addMarker(marker2);
    var marker3 = MarkerOptions(
        position: LatLng(51.747208, 19.453742),                                       //Polibuda
//        position: LatLng(51.590969, 19.159729),                                     //Home
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindowText: InfoWindowText("Lodex","")
    );
    controller.addMarker(marker3);
*/
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
//  void _checkPoints() async {
//    var location = new Location();
//    var pos = await location.getLocation();
//    if(instruction) {
//      setState(() {
//        _popAd(context, "Dziękujemy za pobranie aplikacji.", "Idź w świat i poznawaj kampus, przy okazji zbieraj punkty i wymieniej je na piwo ;)");
//      });
//      instruction = false;
//    }
//    if( abs(pos.latitude - 51.589825 ) < 0.00012 && abs(pos.longitude - 19.158243 ) < 0.00012) {
//      setState(() {
//        _popAd(context, "Brawo", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//    if( abs(pos.latitude - 51.590552 ) < 0.00052 && abs(pos.longitude - 19.158772 ) < 0.00052) {
//      setState(() {
//        _popAd(context, "Niemożliwe", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//    if( abs(pos.latitude - 51.590969) < 0.00052 && abs(pos.longitude - 19.159729 ) < 0.00052) {
//      setState(() {
//        _popAd(context, "Zabka", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//    if( abs(pos.latitude - 51.590459 ) < 0.00052 && abs(pos.longitude - 19.160708 ) < 0.00052) {
//      setState(() {
//        _popAd(context, "łaka", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//    if( abs(pos.latitude - 51.589092 ) < 0.00052 && abs(pos.longitude - 19.158801 ) < 0.00052) {
//      setState(() {
//        _popAd(context, "Kotłownia", "Udało Ci się! Zdobyłeś 100 punktów!");
//      });
//      userPoints += 100;
//    }
//
//  }
//  double abs(double x) {
//    return x < 0 ? -x : x;
//  }
//  Future<void> _popAd(BuildContext context, String title, String text) async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text(title),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                Text(text),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('OK'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
}