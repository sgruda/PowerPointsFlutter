import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Constans.dart';
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