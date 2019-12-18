import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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