import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Database/DatabaseMarker.dart';
import 'package:flutter_base/Model/Constans.dart';
import 'package:flutter_base/Model/QRCode.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_base/Database/DatabaseCoupon.dart';
import 'package:flutter_base/Database/DatabaseUsers.dart';

class ProfileMenu extends StatefulWidget {
  @override
  ProfileMenuState createState() {
    return ProfileMenuState();
  }
}

class ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
//        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: decideImageView(115)
            ),
            SizedBox(height: 30,),
            Center(child: AutoSizeText(
              //userName,
              'placeholder',
              style: TextStyle(fontSize: 35),
              maxLines: 1,)
            ),
            Padding(padding: EdgeInsets.all(40),)
          ],
        ),
        //child: Text("Morty",style: TextStyle(color: Colors.white,fontSize: 35),),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 200,
        child: FittedBox(
          child: FloatingActionButton.extended(
            label: Text("Edytuj profil"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditMenu()),);
            },
            icon: Icon(Icons.assignment_ind),
//            backgroundColor: Colors.deepOrange,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


Widget decideImageView(double rad){
  {
    return CircleAvatar(
      radius: rad,
      backgroundColor: color7,
      child: CircleAvatar(
          radius: rad*0.9,
          backgroundColor: color3,
          child: imageFile == null
          ? Icon(Icons.person, size: rad*1.3, color: Colors.white,)
          : CircleAvatar(backgroundImage: new FileImage(imageFile), radius: 200.0, backgroundColor: color3),
      )
    );
  }
}


class EditMenu extends StatefulWidget {
  @override
  _EditMenuState createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {

  openGallery() async{
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){}); //refresh page
    Navigator.of(context).pop();
  }

  openCamera() async{
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){}); //refresh page
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Wybierz"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              InkWell(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Gallery")),
                onTap: (){
                  openGallery();
                },
              ),
              InkWell(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Camera")),
                onTap: (){
                  openCamera();
                },
              )
            ],
          ),
        ),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edycja profilu"),
//        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 25),
              child: Column(
                children: <Widget>[
                  Center(
                    child: decideImageView(115)
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0)
                  ),
                  RaisedButton(
                    onPressed: (){
                      showChoiceDialog(context);
                    },
                    child: Text("Zmień zdjęcie"),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: EditNickForm()
            ),
          ],
        ),
      ),
    );
  }

}


class EditNickForm extends StatefulWidget {
  @override
  EditNickFormState createState() {
    return EditNickFormState();
  }
}


class EditNickFormState extends State<EditNickForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Wprowadź nowy nick',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Pole nie może być puste';
              }
              //userName = value;//nie działa jak powinno
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();// hides keyboard
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Zmieniono nick')));
                  }
                },
                child: Text('Zmień nick'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


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
          title: Text("Points"),
//          backgroundColor: Colors.deepOrange,
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


class DataBaseMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Database"),
//          backgroundColor: Colors.deepOrange,
        ),
      body: Column(
        children: <Widget>[
          Text("Coupons"),
          Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read'),
                  onPressed: () {
                    getCoupon(1);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    addCoupon('Piwo','assets/piwo_low.jpg', 'assets/piwo.jpg', 30, 'Kup jedno piwo w cenie dwóch i kolejne otrzymaj gratis! :0', false);
                    addCoupon('Ukończenie studiów', 'assets/zaliczenie_low.jpg', 'assets/zaliczenie.jpg', 20, 'Pokaż rektorowi ten kupon i skończ studia wcześniej niż twoi rówieśnicy!', false);
                    addCoupon('Zabieg dentystyczny', 'assets/slav.jpg', 'assets/slav.jpg', 30, 'Pokaż ten kupon dresowi, a otrzymasz darmowe prostowanie zębów.', false);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Delete all'),
                  onPressed: () {
                    deleteAllCoupons();
                  },
                ),
              ),
            ],
          ),
          Text("Markers"),
          Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read'),
                  onPressed: () {
                    getMarker(5);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    addMarker(
                        51.747179, 19.453392,
                        "O winda!", "",
                        "Brawo", "Udało Ci się znaleźć windę. Zdobyłeś 10 punktów! Czy wiedziałeś, że często się psują?",
                        10, true);
                    addMarker(
                        51.747208, 19.453742,
                        "Lodex", "",
                        "Niemożliwe", "Udało Ci się zobaczyć Lodex => budenek trzech wydziałów! Zdobyłeś 20 punktów!",
                        10, true);
                    addMarker(
                        51.747208, 19.453742,
                        "Kącik.", "",
                        "Kącik sali.", "Stoisz w kącie! Zdobyłeś 10 punktów!",
                        10, true);
                    addMarker(
                        51.589825, 19.158179,
                        "blok.", "",
                        "dgsg", "Stoisz w kącie! Zdobyłeś 10 punktów!",
                        10, true);
                    addMarker(
                        51.755231, 19.530784,
                        "Klepek", "",
                        "Dom Klepka", "Przystań Bogów",
                        100, true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Delete all'),
                  onPressed: () {
                    deleteAllMarker();
                  },
                ),
              ),
            ],
          ),
          Text("User"),
          Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read'),
                  onPressed: () {
                    getUser(1);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    addUser('Klepek', 100);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Delete all'),
                  onPressed: () {
                    deleteAllUsers();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

