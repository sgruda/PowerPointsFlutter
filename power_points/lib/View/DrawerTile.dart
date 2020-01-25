import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';



class DrawerTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;

  DrawerTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0,0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: color6))
        ),
        child: InkWell(
//            splashColor: Colors.grey,
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