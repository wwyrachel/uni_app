import 'package:flutter/material.dart';
import 'location_model.dart';
import 'location_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'post_model_2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Upload_page.dart';

class PostHomePage extends StatefulWidget {

  State createState() => new PostHomePageState();
}

class PostHomePageState extends State<PostHomePage> {
  @override

  List<Posts> postsList =[];

  void initState(){
    super.initState();
    DatabaseReference postRef = FirebaseDatabase.instance.reference().child("Posts");
    postRef.once().then((DataSnapshot snap){
      var KEYS =snap.value.keys;
      var DATA = snap.value;

      postsList.clear();

      for (var individualKey in KEYS){
        Posts posts = new Posts(
          DATA[individualKey]["image"],
          DATA[individualKey]["description"],
            DATA[individualKey]["date"],
            DATA[individualKey]["time"]
        );

        postsList.add(posts);
      }

      setState(() {
        print('Length: $postsList.length');
      });
    });
  }
  Widget build(BuildContext context) {

    return new Material(
        color: Colors.greenAccent,
        child: new Scaffold(
          backgroundColor: Color(0xFFE8F5E9),
            body: new Container(
              child: Center(
                child: postsList.length== 0? new CircularProgressIndicator(): new ListView.builder(itemCount: postsList.length,itemBuilder: (_,index){
                  return PostsUI(postsList[index].image, postsList[index].description, postsList[index].date, postsList[index].time);
                }),
              )
            ),
          floatingActionButton: new FloatingActionButton(
            onPressed: goToUploadPage,
            tooltip: "Create new post",
            child: new Icon(Icons.add),),

        )
    );
  }
  Widget PostsUI(String image, String description, String date, String time){
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: new Container(
        padding: new EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Icon(Icons.event, size: 15.0,),
                    new SizedBox(width: 5.0,),
                    new Text(date),
                  ],
                ),
                Row(
                  children: <Widget>[
                    new Icon(Icons.access_time, size: 15.0,),
                    new SizedBox(width: 5.0,),
                    new Text(time),
                  ],
                )
              ],
            ),

            SizedBox(height: 10.0,),
            new Image.network(image, fit: BoxFit.cover,),
            SizedBox(height: 10.0,),
            new Text(description),



          ],
        ),
      ),
    );
  }

  void goToUploadPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context){
          return UploadPage();
        }
        )
    );
  }





}

