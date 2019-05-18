import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'post_home.dart';

class UploadPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return UploadPageState();
  }
}

class UploadPageState extends State<UploadPage>{

  File sampleImage;
  String myValue;
  String url;
  final formKey = new GlobalKey<FormState>();

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  void uploadStatusImage() async{
    if (validateAndSave()){
      final StorageReference postImageRef = FirebaseStorage.instance.ref().child("Post Images");

      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      url=ImageUrl.toString();
      print("Image Url = "+ url);
      goToHomePage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url){

    var now = new DateTime.now();
    var dbTimeKey = now.toLocal().add(Duration(hours: 8));
    var formatDate = new DateFormat("MMM d, yyyy");
    var formatTime = new DateFormat("EEEE, hh:mm aaa");

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data={
      "image": url,
      "description": myValue,
      "date": date,
      "time": time,
    };

    ref.child("Posts").push().set(data);
  }

  void goToHomePage(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context){
          return PostHomePage();
        }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      resizeToAvoidBottomPadding: false,


      body: new Center(
        child: sampleImage == null? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Icon(Icons.image, size: 70,),
          SizedBox(height: 10,),
          Text("Select an Image", style: TextStyle(fontSize: 20),)
        ],): enableUpload(),
      ),

      floatingActionButton: new FloatingActionButton(
          onPressed: getImage,
      tooltip: "Add Image",
      child: new Icon(Icons.add_a_photo),),

    );
  }

  Widget enableUpload(){
    return Container(
      child: new Form(
        key: formKey,

        child: Column(
          children: <Widget>[
            Image.file(sampleImage, height: 250.0, width: 630,),

            SizedBox(height: 3.0,),
            TextFormField(
              decoration: new InputDecoration(labelText: "Description"),

              validator: (value){
                return value.isEmpty? "Bold Description is required!" : null;

              },
              onSaved: (value){
                return myValue = value;
              },
            ),
            SizedBox(height: 8.0,),
            RaisedButton(
              elevation: 10.0,
              child:  Text("Add Post"),
              textColor: Colors.white,
              color: Colors.pink,
              onPressed: uploadStatusImage,
            ),


          ],
        ),
      ),
    );
  }
}