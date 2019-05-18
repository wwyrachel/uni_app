import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Methods{
  bool isLoggedIn(){
    if (FirebaseAuth.instance.currentUser() != null){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> addData(data) async{
    if (isLoggedIn()){
      Firestore.instance.collection("events").add(data).catchError((e){
        print(e);
      });
    }
    else{
      print("You need to be logged in");
    }
  }

  getData() async{
    return  await Firestore.instance.collection("events").getDocuments();
  }
}