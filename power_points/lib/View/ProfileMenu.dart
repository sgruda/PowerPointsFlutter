import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_base/Database/DatabaseUsers.dart';

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



class ProfileMenu extends StatefulWidget {
  @override
  ProfileMenuState createState() {
    return ProfileMenuState();
  }
}

class ProfileMenuState extends State<ProfileMenu> {
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
        title: Text("Profil"),
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
            Center(child: FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return AutoSizeText(
                    //userName,
                    snapshot.data.name,
                    style: TextStyle(fontSize: 35),
                    maxLines: 1,);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Data Found');
                }
                return CircularProgressIndicator();

              },
            ),
            ),
            Padding(padding: EdgeInsets.all(40),)
          ],
        ),
        //child: Text("Morty",style: TextStyle(color: Colors.white,fontSize: 35),),
      ),
//      floatingActionButton: Container(
//        height: 60,
//        width: 200,
//        child: FittedBox(
//          child: FloatingActionButton.extended(
//            label: Text("Edytuj profil"),
//            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) => EditMenu()),);
//            },
//            icon: Icon(Icons.assignment_ind),
////            backgroundColor: Colors.deepOrange,
//          ),
//        ),
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    child: Text("Galeria")),
                onTap: (){
                  openGallery();
                },
              ),
              InkWell(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Kamera")),
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
              changeNameUser(1, value);

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