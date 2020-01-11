import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/Model/Constans.dart';
import 'package:flutter_base/Model/QRCode.dart';
import 'package:image_picker/image_picker.dart';



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
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: decideImageView()
            ),
            SizedBox(height: 30,),
            Center(child: AutoSizeText(
              userName, 
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
            backgroundColor: Colors.deepOrange,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


Widget decideImageView(){
  if(imageFile == null){
    return CircleAvatar(
      radius: 115,
      backgroundColor: Colors.deepOrange,
      child: CircleAvatar(
          radius: 105,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 100, color: Colors.grey,)),
    );
  }
  else{
    return Container(
      height: 230,
      width: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(115),
          color: Colors.white,
          border: Border.all(
              width: 10,
              color: Colors.deepOrange
          ),
          image: DecorationImage(
              image: AssetImage(imageFile.path),
              fit: BoxFit.cover
          )
      ),
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
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  openGallery();
                },
              ),
              Padding(padding: EdgeInsets.all(8),),
              GestureDetector(
                child: Text("Camera"),
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
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30, 40, 30, 25),
              child: Column(
                children: <Widget>[
                  Center(
                    child: decideImageView()
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
              userName = value;//nie działa jak powinno
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
class QRCodeTest extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return GenerateScreen("Jej, testutuje, wincyj");
  }
}