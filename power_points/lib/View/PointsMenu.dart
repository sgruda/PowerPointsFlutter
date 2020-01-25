import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';
import 'package:flutter_base/Database/DatabaseUsers.dart';


class PointsMenu extends StatefulWidget {
  @override
  _PointsMenuState createState() => _PointsMenuState();
}

class _PointsMenuState extends State<PointsMenu> {
  DBUsersHelper dbHelper;

  Future<User> user;

  @override
  void initState() {
    super.initState();
    dbHelper = DBUsersHelper();
    refreshUserList();
  }

  refreshUserList(){
    setState(() {
      user = dbHelper.getUser(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Punkty"),
//          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: Text("Liczba punktów", style: TextStyle(fontSize: 35),)),
              SizedBox(height: 30,),
              Center(
                  child:CircleAvatar(
                      radius: 60,
                      backgroundColor: color4,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: color3,
                        child: FutureBuilder(
                          future: user,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data.points.toString(), style: TextStyle(fontSize: 50, color: color5));
                            }
                            if (snapshot.data == null || snapshot.data.length == 0) {
                              return Text('No Data Found');
                            }
                            return CircularProgressIndicator();

                          },
                        ),
                      )
                  )
              )
            ],
          ),
        )
    );
  }
}
