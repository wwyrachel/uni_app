import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_manage.dart';


class AdminRegisteredEventAllPage extends StatefulWidget{
  const AdminRegisteredEventAllPage({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  AdminRegisteredEventAllPageState createState() => new AdminRegisteredEventAllPageState();
}

class AdminRegisteredEventAllPageState extends State<AdminRegisteredEventAllPage> {

  @override
  Widget build(BuildContext context) {
    //String user_email= widget.user.email;
    // TODO: implement build
    return AspectRatio(
      aspectRatio: 100/100,
      child: new Scaffold(
        backgroundColor: Color(0xFFE8F5E9),
        body:Center(child: AdminRegisteredEventContent(user: widget.user,
        )),
      ),
    );
  }

}


class AdminRegisteredEventContent extends StatefulWidget{
  const AdminRegisteredEventContent({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  AdminRegisteredEventContentState createState() => new AdminRegisteredEventContentState();
}



class AdminRegisteredEventContentState extends State<AdminRegisteredEventContent> {
  String newEvent= "";
  String newUserName="";
  String newImageURL="";
  String newID="";
  String newHostDept="";


  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("register").getDocuments();
    return qn.documents;
  }
  @override

  void _showErrorAlert(){

    AlertDialog dialog = new AlertDialog(
      title: new Row(
        children: <Widget>[
          new Icon(Icons.thumb_up),
          new SizedBox(width: 7.0,),
          new Text("Successful")
        ],
      ),
      content: new Text("Event registered successfully! Please attend the event on time!", style: TextStyle(fontSize: 20),),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: new Text("OK"))
      ],
    );
    showDialog(context: context, child: dialog);
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _addData(){
      Firestore.instance.runTransaction((Transaction transaction) async{
        CollectionReference reference = Firestore.instance.collection("register");
        await reference.add(
            {
              "event":  newEvent,
              "user": newUserName,
              "eventID": newID,
              "imageURL": newImageURL,
              "host_dept": newHostDept

            }
        );
      }
      );

    }

    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot){

            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else{

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index){
                    return Padding(
                      padding: const EdgeInsets.only(top:8.0, left:8.0, right: 8.0),
                      child: Card(
                        elevation: 5.0,
                        child: Container(
                          width: 200,


                          child: Column(
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //new Container(

                                  Expanded(child: new Image.network(snapshot.data[index].data["imageURL"], height: 240, fit: BoxFit.cover,))

                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:20, right:20, top:20, bottom:12),
                                child: new Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            child: new Text(snapshot.data[index].data["event"],
                                              style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                                          ),
                                          //new Text("${snapshot.data[index].data["date"].toString()} ${snapshot.data[index].data["time"]}",style: TextStyle(color: Colors.grey),),
                                        ],
                                      ),
                                    ),

                                    //new Text(snapshot.data[index].data["duration"].toString()+ " hr"),
                                  ],
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.only(top:5.0,left:20, right: 20, bottom:10),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        new Icon(Icons.school),
                                        new SizedBox(width: 5.0,),
                                        new Text(snapshot.data[index].data['host_dept'], style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        new Icon(Icons.local_offer),
                                        new SizedBox(width: 5.0,),
                                        new Text(snapshot.data[index].data['eventID'].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    ),




                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:20.0, right: 20.0, top: 6, bottom: 6),
                                child: Row(
                                  children: <Widget>[
                                    Text("Registered Users:", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5.0,left:20, right: 20, bottom:10),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        new Icon(Icons.person),
                                        new SizedBox(width: 5.0,),
                                        new Text(snapshot.data[index].data['user'], style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    ),




                                  ],
                                ),
                              )

                              //ListTile(
                              //  title:  Text(snapshot.data[index].data["name"], style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                              //),
                            ],
                          ),
                        ),
                      ),
                    );


                  });
            }
          }),
    );
  }




}

