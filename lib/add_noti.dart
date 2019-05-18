import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'add_blank_noti.dart';
import 'edit_jobs.dart';
import 'edit_noti.dart';
import 'dart:io';


class AdminNotiAllPage extends StatefulWidget{
  AdminNotiAllPageState createState() => new AdminNotiAllPageState();
}

class AdminNotiAllPageState extends State<AdminNotiAllPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body:Center(child: AdminNotiContent()),
    );
  }
}

class AdminNotiContent extends StatefulWidget{
  State<StatefulWidget> createState() => AdminNotiContentState();
}



class AdminNotiContentState extends State<AdminNotiContent> {

  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("notifications").getDocuments();
    return qn.documents;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFE8F5E9),

      body: Container(
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


                            child: Column(
                              children: <Widget>[

                                Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  color: snapshot.data[index].data["type"]== "event"?Color(0xFFFFE082): (snapshot.data[index].data["type"]== "job"?Color(0xFFBBDEFB): Color(0xFFFFCDD2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Text(snapshot.data[index].data["dept"],),

                                        Row(
                                          children: <Widget>[
                                            new Icon(Icons.access_time, size: 15,),
                                            new SizedBox(width: 5.0,),
                                            new Text(snapshot.data[index].data["postDate"],),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Row(

                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0, right: 8.0, top:12, bottom:8.0),
                                      child: new Text(snapshot.data[index].data["title"],style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                    ),


                                  ],
                                ),
                                Row(

                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          width: width-60,
                                          child: new Text(snapshot.data[index].data["content"],style: TextStyle(fontSize: 15),)

                                      ),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ),




                                Padding(
                                  padding: const EdgeInsets.only(top: 5,bottom:20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){

                                            AlertDialog dialog = new AlertDialog(
                                              title: new Row(
                                                children: <Widget>[
                                                  new Icon(Icons.warning),
                                                  new SizedBox(width: 7.0,),
                                                  new Text("Confirm")
                                                ],
                                              ),
                                              content: new Text("Are you sure to delete this item permanently?", style: TextStyle(fontSize: 20),),
                                              actions: <Widget>[
                                                new FlatButton(onPressed: (){
                                                  Firestore.instance.runTransaction((Transaction transaction) async{
                                                    DocumentSnapshot snapshot1=
                                                    await transaction.get(snapshot.data[index].reference);
                                                    await transaction.delete(snapshot1.reference);
                                                  });

                                                  //sleep(const Duration(seconds:3));
                                                    Navigator.pop(context);
                                                  AlertDialog dialog = new AlertDialog(
                                                    title: new Row(
                                                      children: <Widget>[
                                                        new Icon(Icons.thumb_up),
                                                        new SizedBox(width: 7.0,),
                                                        new Text("Successful")
                                                      ],
                                                    ),
                                                    content: new Text("Record has been deleted! Please refresh page!", style: TextStyle(fontSize: 20),),
                                                    actions: <Widget>[
                                                      new FlatButton(onPressed: (){


                                                        //sleep(const Duration(seconds:3));
                                                        Navigator.pop(context);




                                                      }, child: new Text("OK")),

                                                    ],
                                                  );
                                                  showDialog(context: context, child: dialog);




                                                }, child: new Text("Yes")),
                                                new FlatButton(onPressed: (){

                                                  //sleep(const Duration(seconds:3));
                                                  Navigator.pop(context);




                                                }, child: new Text("Cancel")),

                                              ],
                                            );
                                            showDialog(context: context, child: dialog);



    },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.delete, color: Colors.blue,),
                                            SizedBox(height: 10,),
                                            Text("DELETE", style: TextStyle(color: Colors.blue),)
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          //navigateToDetail(snapshot.data[index]);
                                        },
                                        child: GestureDetector(

                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => new EditDetailNotiPage(
                                              CompanyName: snapshot.data[index].data["type"],
                                              PostDate: snapshot.data[index].data["date"].toString(),
                                              CompanyDes: snapshot.data[index].data["content"],
                                              CompanyEmail: snapshot.data[index].data["dept"],
                                              JobID: snapshot.data[index].data["id"],
                                              JobName: snapshot.data[index].data["title"],
                                              index: snapshot.data[index].reference,


                                            )));
                                          },

                                          child: Column(
                                            children: <Widget>[
                                              Icon(Icons.edit, color: Colors.blue,),
                                              SizedBox(height: 10,),
                                              Text("EDIT", style: TextStyle(color: Colors.blue),)
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),



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

      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBlankDetailNotiPage()));
          //navigateToDetail();
          //Firestore.instance.collection("events").document().setData({"name":"123", "location":"abc"});
        },
        tooltip: "Add Notification",
        child: new Icon(Icons.add),),
    );
  }


}


