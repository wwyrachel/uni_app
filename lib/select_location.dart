import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'news_page.dart';
import "login_page_2.dart";
import 'main.dart';
import 'home_page.dart';
import 'food_content.dart';
import 'food_content_cu.dart';
import 'explore_page.dart';
import 'food_content_hku.dart';
import 'food_content_hkust.dart';
import 'food_content_bu.dart';
import 'food_content_lingu.dart';
import 'food_content_ou.dart';
import 'food_content_syu.dart';

class SelectLocationPage extends StatefulWidget{
  const SelectLocationPage({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  @override
  SelectLocationPageState createState() => SelectLocationPageState();
}

class SelectLocationPageState extends State<SelectLocationPage>{

  int _currentIndex=0;
  Widget callPage(int currentIndex){
    switch(currentIndex){
      case 0: return HomeContent();
      case 1: return ExplorePage();
      case 2: return LoginPage2();
      case 3: return MyHomePage();

      break;
      default:return HomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: new Scaffold(
        backgroundColor: Color(0xFFE8F5E9),
        body: Center(child: SelectLocationContent()),

      ),
    );
  }
}



class SelectLocationContent extends StatelessWidget{
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
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          new Icon(Icons.location_on, size: 30,),
                          new SizedBox(width: 5.0,),
                          new Text("LOCATION", style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        ],
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HKUPlacesPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new ExactAssetImage("assets/images/hku.jpg"),
                                    fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white,size: 30,),
                                SizedBox(width: 10.0,),
                                SizedBox(
                                    width: 200,
                                    child: Text("The University of Hong Kong ",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 300,
                            height: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CUPlacesPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(5.0),
                              image: new DecorationImage(
                                  image: new ExactAssetImage("assets/images/cu_1.jpg"),
                                  fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white,size: 30,),
                                SizedBox(width: 10.0,),
                                SizedBox(
                                  width: 200,
                                    child: Text("The Chinese University of Hong Kong",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 300,
                            height: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HKUSTUPlacesPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new ExactAssetImage("assets/images/hkust_1.jpg"),
                                    fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white,size: 30,),
                                SizedBox(width: 10.0,),
                                SizedBox(
                                    width: 200,
                                    child: Text("The Hong Kong University of Science and Technology",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 300,
                            height: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 2.0,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PlacesPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new ExactAssetImage("assets/images/2.jpg"),
                                    fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white,size: 30,),
                                SizedBox(width: 10.0,),
                                SizedBox(
                                    width: 200,
                                    child: Text("The Hong Kong Polytechnic University",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 300,
                            height: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 2.0,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BUPlacesPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new ExactAssetImage("assets/images/bu_1.jpg"),
                                    fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white,size: 30,),
                                SizedBox(width: 10.0,),
                                SizedBox(
                                    width: 200,
                                    child: Text("Hong Kong Baptist University",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 300,
                            height: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LINGUPlacesPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new ExactAssetImage("assets/images/lingu_1.jpg"),
                                    fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white,size: 30,),
                                SizedBox(width: 10.0,),
                                SizedBox(
                                    width: 200,
                                    child: Text("The Lingnan University",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 300,
                            height: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SYUPlacesPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new ExactAssetImage("assets/images/syu_1.jpg"),
                                    fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white,size: 30,),
                                SizedBox(width: 10.0,),
                                SizedBox(
                                    width: 200,
                                    child: Text("The Hong Kong Shue Yan University",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 300,
                            height: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 5.0,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OUPlacesPage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                image: new DecorationImage(
                                    image: new ExactAssetImage("assets/images/ou.png"),
                                    fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white,size: 30,),
                                SizedBox(width: 10.0,),
                                SizedBox(
                                    width: 200,
                                    child: Text("The Open University of Hong Kong",
                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 300,
                            height: 100,
                          ),
                        ),
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

