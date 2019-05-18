import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'news_page.dart';
import "login_page_2.dart";
import 'main.dart';
import 'home_page.dart';
import 'food_content.dart';
import 'jobs_page.dart';
import 'event_page.dart';
import 'user_info1.dart';
import 'post_home.dart';
import "links_page.dart";
import 'add_jobs.dart';
import 'select_location.dart';
import 'add_event.dart';
import 'userInfo3.dart';
import "home_admin.dart";

class AdminExplorePage extends StatefulWidget{
  const AdminExplorePage({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  @override
  _AdminExplorePageState createState() => _AdminExplorePageState();
}

class _AdminExplorePageState extends State<AdminExplorePage>{

  int _currentIndex=0;
  Widget callPage(int currentIndex){
    switch(currentIndex){
      case 0: return AdminHomeContent();
      case 1: return AdminExplorePage();
      case 2: return AdminExplorePage();
      case 3: return UserInfoPage1();

      break;
      default:return AdminHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: new Scaffold(
        backgroundColor: Color(0xFFE8F5E9),
        body: AdminExploreContent(),

      ),
    );
  }
}



class AdminExploreContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(

      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: new Container(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: MediaQuery.of(context).size.height/12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          Icon(Icons.explore, size: 30,),
                          SizedBox(width: 8,),
                          new Text("EXPLORE", style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        ],
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Color(0xFF2e7d32),
                                  ),
                                  height: 135,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(Icons.event, color: Colors.white,size: 30,),
                                      new SizedBox(
                                        height: 8.0,
                                      ),
                                      new Text("Events",style: TextStyle(color: Colors.white, fontSize: 20),)
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventPage()));
                                },
                              ),
                              elevation: 5.0,
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsContent()));
                                },
                                child: Container(

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Color(0xFF795548),
                                  ),
                                  height: 135,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[

                                      new Icon(Icons.new_releases, color: Colors.white,size: 30,),
                                      new SizedBox(
                                        height: 8.0,
                                      ),
                                      new Text("News",style: TextStyle(color: Colors.white, fontSize: 20),)
                                    ],
                                  ),
                                ),
                              ),
                              elevation: 5.0,
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostHomePage()));
                                },
                                child: Container(

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Color(0xFF009688),
                                  ),
                                  height: 135,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(Icons.forum, color: Colors.white,size: 30,),
                                      new SizedBox(
                                        height: 8.0,
                                      ),
                                      new Text("Journal",style: TextStyle(color: Colors.white, fontSize: 20),)
                                    ],
                                  ),
                                ),
                              ),
                              elevation: 5.0,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectLocationPage()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Color(0xFF8bc34a),
                                  ),
                                  height: 135,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(Icons.local_dining, color: Colors.white,size: 30,),
                                      new SizedBox(
                                        height: 8.0,
                                      ),
                                      new Text("Food",style: TextStyle(color: Colors.white, fontSize: 20),)
                                    ],
                                  ),
                                ),
                              ),
                              elevation: 10.0,
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminJobsAllPage()));
                                },
                                child: Container(

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.0),
                                      color: Color(0xFF546e7a)
                                  ),
                                  height: 135,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(Icons.card_travel, color: Colors.white,size: 30,),
                                      new SizedBox(
                                        height: 8.0,
                                      ),
                                      new Text("Jobs",style: TextStyle(color: Colors.white, fontSize: 20),)
                                    ],
                                  ),
                                ),
                              ),
                              elevation: 10.0,
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LinksPage()));
                                },
                                child: Container(

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Color(0xFF006064),
                                  ),
                                  height: 135,
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Icon(Icons.insert_link, color: Colors.white,size: 30,),
                                      new SizedBox(
                                        height: 8.0,
                                      ),
                                      new Text("Links",style: TextStyle(color: Colors.white, fontSize: 20),)
                                    ],
                                  ),



                                ),
                              ),
                              elevation: 10.0,
                            ),
                          )
                        ],
                      )
                    ],
                  ),

                ],


              )
          ),
        )
      ],
    );

  }

}

