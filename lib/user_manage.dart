import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userInfo3.dart';
import 'package:flutter/widgets.dart';
import 'login_page_2.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'explore_admin.dart';
import 'home_admin.dart';
import 'home_page.dart';
import 'sign_up.dart';

class UserManagement{
  String name = "";
  Widget handleAuth(){
    return new StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if (snapshot.hasData){
          return UserInfoPage3();
        }
        return LoginPage2();
      },
    );
  }

  void _showErrorAlert(BuildContext context){

    AlertDialog dialog = new AlertDialog(
      title: new Row(
        children: <Widget>[
          new Icon(Icons.warning),
          new SizedBox(width: 7.0,),
          new Text("Error")
        ],
      ),
      content: new Text("Email has been registered. Please use another email!", style: TextStyle(fontSize: 20),),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
        }, child: new Text("OK"))
      ],
    );
    showDialog(context: context, child: dialog);
  }

  authorizeAccess(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("users").where("uid", isEqualTo: user.uid).getDocuments().then((docs){
        if (docs.documents[0].data["role"]== "admin"){
          print("admin");
          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomePage(user: user,)));
        }
        if (docs.documents[0].data["role"] == "user"){
          print("user");
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user,)));
        }

        /*
        else{
          print("Not Authorized");
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
        }
        */
      });
    });

  }


  String getName(BuildContext context){
    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("users").where("uid", isEqualTo: user.uid).getDocuments().then((docs){
        if (docs.documents[0].data["role"]== "admin"){
          return ("admin");
          //Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHomePage(user: user,)));
        }
        if (docs.documents[0].data["role"] == "user"){
          return ("user");
         // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user,)));
        }

        /*
        else{
          print("Not Authorized");
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
        }
        */
      });
    });
  }

  String UserName() {

    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection("users").where("uid", isEqualTo: user.uid).getDocuments().then((docs){
         name=docs.documents[0].data["name"];
        //return docs.documents[0].data["name"].toString();
        return name;
        /*
        else{
          print("Not Authorized");
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
        }
        */
      });
      //print ("name1'");
      //return name;

    });
    //print ("name2'");
    //return name;

  }

  signOut(){
    FirebaseAuth.instance.signOut();
  }
}