import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'explore_page.dart';
import "login_page_2.dart";
import 'post_home.dart';
import 'event_page.dart';
import 'links_page.dart';
import 'news_page.dart';
import 'select_location.dart';
import 'jobs_page.dart';
import 'user_info1.dart';
import 'package:flutter/animation.dart';
import 'explore_admin.dart';
import 'user_manage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'noti_page.dart';
import 'home_page.dart';

class NotiPage extends StatefulWidget{
  const NotiPage({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;


  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage>{

  //int _currentIndex=0;
  //Widget callPage(int currentIndex){
  //  switch(currentIndex){
  //    case 0: return HomeContent(user: widget.user,);
  //    case 1: return ExplorePage(user: widget.user,);
  //    case 2: return NotiPage(user: widget.user,);
  //    case 3: return UserInfoPage1(user: widget.user,);

  //    break;
  //    default:return HomeContent(user: widget.user,);
  //  }
  //}


  String newEvent= "";
  String newUserName="";


  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("notifications").getDocuments();
    return qn.documents;
  }
  @override


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
              "user": newUserName
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
                      child: GestureDetector(
                        onTap: (){
                          if (snapshot.data[index].data["type"]== "event"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EventAllPage()));
                          }
                          else if(snapshot.data[index].data["type"]== "job"){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => JobsAllPage()));
                          }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PostHomePage()));
                          }

                        },
                        child: Card(
                          elevation: 5.0,
                          child: Container(
                            width: 200,


                            child: Padding(
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
                            )
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




