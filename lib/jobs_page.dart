import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';


class JobsAllPage extends StatefulWidget{
  JobsAllPageState createState() => new JobsAllPageState();
}

class JobsAllPageState extends State<JobsAllPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body:Center(child: JobsContent()),
    );
  }
}

class JobsContent extends StatefulWidget{
  State<StatefulWidget> createState() => JobsContentState();
}



class JobsContentState extends State<JobsContent> {

  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("jobs").getDocuments();
    return qn.documents;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
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
                                          new Text(snapshot.data[index].data["postDate"].toString(),style: TextStyle(color: Colors.grey),),
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
                                          child: new Text(snapshot.data[index].data["description"], softWrap: true,textAlign: TextAlign.justify,)
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
                                padding: const EdgeInsets.only(top:2.0, right: 20.0, bottom: 15.0,left:20),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          new Text("Salary: HKD "+snapshot.data[index].data["salary"].toString()+ " / month",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.blueGrey),)
                                        ],
                                      ),
                                    ),
                                    SizedBox(width:width/15),

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

/*
Center(
child: new Container(
child: ListTile(
title: Text(snapshot.data[index].data["name"], style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
//leading: Image.asset("assets/images/1.jpg", scale:1.0, height: 60,),
subtitle: Text(snapshot.data[index].data["date"].toString()),
),

),
);
*/
