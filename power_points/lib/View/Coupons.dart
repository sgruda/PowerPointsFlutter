import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';
import 'package:flutter_base/Model/QRCode.dart';
import 'package:flutter_base/View/Menu.dart';

class CouponsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupons"),
        actions: <Widget>[
          Text("Punkty: " + userPoints.toString())
        ],
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

class CouponCard extends StatefulWidget {
  Coupon coupon;

  CouponCard(this.coupon);

  @override
  State<StatefulWidget> createState() {
    return CouponCardState();
  }

}

class CouponCardState extends State<CouponCard>{
  Coupon coupon;
  bool isTapped = false;

  @override
  void initState(){
    coupon = widget.coupon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupons"),
        actions: <Widget>[
          Text("Punkty: " + userPoints.toString())
        ],
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.grey[100],
      body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(40, 20, 40, 120),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(coupon.imagePath),
                  fit: BoxFit.cover
                )
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isTapped = !isTapped;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.decelerate,
                    padding: EdgeInsets.all(15.0),
                    height: isTapped ? 300 : 70,
                    width: isTapped ? 240 : 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: isTapped ? BorderRadius.circular(20) : BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40.0,
                          color: Colors.black12,
                          spreadRadius: 5.0
                        )
                      ]
                    ),
                    child: ListView(
                      children: <Widget>[
                        AutoSizeText(
                          coupon.title,
                          style: TextStyle(fontSize: 20),
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          "Cena: " + coupon.price.toString(),
                          style: TextStyle(fontSize: 10),
                          maxLines: 1,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
                        AutoSizeText(
                          coupon.description,
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ),
          ]
        ),
      floatingActionButton: AnimatedContainer(
        duration: Duration(microseconds: 1),
        height: 60,
        width: 200,
        child: (coupon.isBought)
        ? FittedBox(
            child: FloatingActionButton.extended(
              label: Text("Kod QR"),
              icon: Icon(Icons.monetization_on),
              backgroundColor: Colors.deepOrange,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateCodeQR(coupon.title + coupon.description)));
              }
            )
        )
        : FittedBox(
          child: FloatingActionButton.extended(
            label: Text("Kup"),
            icon: Icon(Icons.monetization_on),
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              setState(() {
                coupon.buy(context);
              });
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Coupon {
  String title;
  String iconImagePath;
  String imagePath;
  int price;
  String description;
  bool  isBought;

  Coupon(this.title, this.iconImagePath, this.imagePath, this.price, this.description){
    this.isBought = false;
  }

  buy(context) async{
    if(userPoints >= this.price && this.isBought == false){
      userPoints -= this.price;
      this.isBought = true;
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Kupiono Kupon"),
            );
          }
      );
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Nie można kupić kuponu"),
          );
        }
      );
    }
  }
}

Widget _myListView(BuildContext context) {



  return ListView.builder(
    itemCount: coupons.length,
    itemBuilder: (context, index) {
      return  Card(
  //        elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(coupons[index].imagePath),
                  fit: BoxFit.cover
                )
              ),
            ),
            title: Text(coupons[index].title),
            subtitle: Text("Cena: " + coupons[index].price.toString()),
  //          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CouponMenu(coupons[index])),);},
            onTap: () {Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => CouponCard(coupons[index]),
                    transitionDuration: Duration(milliseconds: 500)),
          );},
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