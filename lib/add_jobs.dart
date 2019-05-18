import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'add_blank_jobs.dart';
import 'edit_jobs.dart';


class AdminJobsAllPage extends StatefulWidget{
  AdminJobsAllPageState createState() => new AdminJobsAllPageState();
}

class AdminJobsAllPageState extends State<AdminJobsAllPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body:Center(child: AdminJobsContent()),
    );
  }
}

class AdminJobsContent extends StatefulWidget{
  State<StatefulWidget> createState() => AdminJobsContentState();
}



class AdminJobsContentState extends State<AdminJobsContent> {

  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("jobs").getDocuments();
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
                                  padding: const EdgeInsets.only(left:20, right:20, top:20, bottom:12),
                                  child: new Row(
                                    children: <Widget>[
                                      new Container(
                                        width: 50.0,
                                        height: 40.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(snapshot.data[index].data["companyLogo"])
                                            )
                                        ),
                                      ),
                                      new SizedBox(
                                        width: 20.0,
                                      ),
                                      Expanded(
                                        child: new Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            new Container(
                                              child: new Text(snapshot.data[index].data["name"],
                                                style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                                            ),
                                            new Text("${snapshot.data[index].data["postDate"].toString()} ${snapshot.data[index].data["time"].toString()}",style: TextStyle(color: Colors.grey),),
                                          ],
                                        ),
                                      ),


                                      new SizedBox(
                                        width: 10,
                                      ),
                                      new Text("ID: "+snapshot.data[index].data["id"].toString()),
                                    ],
                                  ),
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //new Container(

                                    Expanded(
                                      child: new Image.network(snapshot.data[index].data["imageURL"],
                                        height: 240, fit: BoxFit.cover,),
                                    )

                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top:0.0),
                                  child: new Row(

                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left:20.0, right: 20.0, bottom:15.0, top:10.0),

                                        child: SizedBox(
                                            width: width-width/5,
                                            child: new Text(snapshot.data[index].data["description"], softWrap: true, textAlign: TextAlign.justify,)
                                        ),

                                      )

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:0.0),
                                  child: new Row(

                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left:20.0, right: 20.0, bottom:15.0),

                                        child: SizedBox(
                                            width: 295,
                                            child: new Text(snapshot.data[index].data["company"], softWrap: true,style: TextStyle(fontWeight: FontWeight.bold),)
                                        ),

                                      )

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:2.0, right: 20.0, bottom: 15.0, left: 20.0),
                                  child: new Row(
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                new Text("Salary: HKD "+snapshot.data[index].data["salary"].toString()+ " / month",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.blueGrey),),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.start,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width:width/15,),

                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: new GestureDetector(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  new Icon(Icons.share, color: Colors.black,size: 30.0,),

                                                ],
                                              ),
                                              onTap: (){
                                                Share.share("${snapshot.data[index].data["company"]} is now recruiting ${snapshot.data[index].data["name"]}. Details: https://www.jijis.org.hk/");
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: width/25,
                                      ),
                                      Container(
                                        child: new GestureDetector(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Icon(Icons.email, color: Colors.black,size: 30,),

                                            ],
                                          ),
                                          onTap: (){
                                            launch("mailto:${snapshot.data[index].data["email"]}");
                                          },
                                        ),
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
                                          /*
                                          Firestore.instance.runTransaction((Transaction transaction) async{
                                            DocumentSnapshot snapshot1=
                                            await transaction.get(snapshot.data[index].reference);
                                            await transaction.delete(snapshot1.reference);
                                          });
                                          */

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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => new EditDetailJobsPage(
                                              CompanyName: snapshot.data[index].data["company"],
                                              PostDate: snapshot.data[index].data["date"].toString(),
                                              CompanyDes: snapshot.data[index].data["description"],
                                              CompanyLogo: snapshot.data[index].data["companyLogo"],
                                              JobID: snapshot.data[index].data["id"].toString(),
                                              JobName: snapshot.data[index].data["name"],
                                              PostTime: snapshot.data[index].data["time"],
                                              JobURL: snapshot.data[index].data["imageURL"],
                                              JobSalary: snapshot.data[index].data["salary"].toString(),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBlankDetailJobsPage()));
          //navigateToDetail();
          //Firestore.instance.collection("events").document().setData({"name":"123", "location":"abc"});
        },
        tooltip: "Add Event",
        child: new Icon(Icons.add),),
    );
  }


}


