import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class userInfo extends StatelessWidget{
  const userInfo({Key key, this.user}): super(key: key);

  final FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),

      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection("user").document(user.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot){
          if (snapshot.hasError){
            return Text("Error ${snapshot.error}");
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting: return Text("Loading...");
            default:
              return Text(snapshot.data["name"]);
          }

        }

      ),
    );
  }

  Center checkRole(DocumentSnapshot snapshot){
    if (snapshot.data["role"]=="admin"){
      print ("admin");
    }
  }
}