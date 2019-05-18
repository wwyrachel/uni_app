import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_manage.dart';


class EventAllPage extends StatefulWidget{
  const EventAllPage({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  EventAllPageState createState() => new EventAllPageState();
}

class EventAllPageState extends State<EventAllPage> {

  @override
  Widget build(BuildContext context) {
    //String user_email= widget.user.email;
    // TODO: implement build
    return AspectRatio(
      aspectRatio: 100/100,
      child: new Scaffold(
        backgroundColor: Color(0xFFE8F5E9),
        body:Center(child: EventContent(user: widget.user,
        )),
      ),
    );
  }

}


class EventContent extends StatefulWidget{
  const EventContent({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  EventContentState createState() => new EventContentState();
}



class EventContentState extends State<EventContent> {
  String newEvent= "";
  String newUserName="";
  String newImageURL="";
  String newID="";
  String newHostDept="";


  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("events").getDocuments();
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
                                        child: new Text(snapshot.data[index].data["name"],
                                        style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                                      ),
                                      new Text("${snapshot.data[index].data["date"].toString()} ${snapshot.data[index].data["time"]}",style: TextStyle(color: Colors.grey),),
                                    ],
                                  ),
                                ),

                                new Icon(Icons.timer),
                                new SizedBox(
                                  width: 10,
                                ),
                                new Text(snapshot.data[index].data["duration"].toString()+ " hr"),
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                              Container(
                                child: new GestureDetector(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(Icons.call, color: Colors.blueAccent,),
                                      new SizedBox(
                                        height: 10,
                                      ),
                                      new Text("CALL", style: TextStyle(color: Colors.blueAccent),)
                                    ],
                                  ),
                                  onTap: (){
                                    launch("tel://27666805");
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  newEvent= snapshot.data[index].data["name"];
                                  newUserName= widget.user.email;
                                  newImageURL= snapshot.data[index].data["imageURL"];
                                  newHostDept= snapshot.data[index].data["host_dept"];
                                  newID=snapshot.data[index].data["id"].toString();

                                  _addData();
                                  _showErrorAlert();
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(Icons.add, color: Colors.blue,),
                                    new SizedBox(
                                      height: 10,
                                    ),
                                    new Text("REGISTER", style: TextStyle(color: Colors.blueAccent),)
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Share.share("Is time to register for the event - ${snapshot.data[index].data["name"].toString()}! Details: https://www.polyu.edu.hk/fh/en-us/news/index");
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(Icons.share, color: Colors.blueAccent),
                                    new SizedBox(
                                      height: 10,
                                    ),
                                    new Text("SHARE", style: TextStyle(color: Colors.blueAccent),)
                                  ],
                                ),
                              )
                            ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:10.0),
                            child: new Row(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top:20.0, left: 20, right: 5, bottom: 5),

                                  child: SizedBox(
                                      width: width-width/5,
                                      child: new Text(snapshot.data[index].data["description"], softWrap: true,textAlign: TextAlign.justify,)),

                                )

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
                                    new Text(snapshot.data[index].data['id'].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
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

