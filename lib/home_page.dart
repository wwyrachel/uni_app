import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'explore_page.dart';
import "qr_code_checkin.dart";
import 'post_home.dart';
import 'event_page.dart';
import 'links_page.dart';
import 'news_page.dart';
import 'select_location.dart';
import 'jobs_page.dart';
import 'user_info1.dart';
import 'package:flutter/animation.dart';
import 'noti_page.dart';
import 'user_manage.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget{
  const HomePage({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  int _currentIndex=0;
  Widget callPage(int currentIndex){
    switch(currentIndex){
      case 0: return HomeContent(user: widget.user,);
      case 1: return ExplorePage(user: widget.user,);
      case 2: return NotiPage(user: widget.user,);
      case 3: return UserInfoPage1(user: widget.user,);

      break;
      default:return HomeContent(user: widget.user,);
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.apps, title: "Services"),
          TabData(iconData: Icons.notifications, title: "Messages"),
          TabData(iconData: Icons.person, title: "Profile")
        ],
        circleColor: Color(0xFF4BB5AB),
        inactiveIconColor: Color(0xFF4BB5AB),
        onTabChangedListener: (position){
          setState(() {
            _currentIndex=position;
          });
        },
      ),
      /*
      appBar: new AppBar(
        title: Text("home ${widget.user.email}"),
          backgroundColor: Colors.transparent,
          elevation: 3.0,
          iconTheme: new IconThemeData(color: Colors.transparent)),
          */
      body: callPage(_currentIndex),

    );
  }
}

class HomeContent extends StatefulWidget{
  const HomeContent({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  HomeContentState createState() => new HomeContentState();
}



class HomeContentState extends State<HomeContent> {
  var images =["https://images.idgesg.net/images/article/2018/10/ai_artificial-intelligence_circuit-board_circuitry_mother-board_nodes_computer-chips-100777423-large.jpg",
  "https://careerconnections.nj.gov/careerconnections/images/hero/RightCareer-480922793.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBNeeQBlnTQPdrHTDqPhLT_4qxjNCdXCDwDAaeiwhHfGr3PioG",
  "http://www.primesourceforum.com/Portals/1/Skins/psf2011/images/photo.jpg",
  "https://www.mca.com.au/files/original_images/145__David_Goldblatt_exhibition__MCA_credit-Anna_Kucera.jpg",
  ];

  var description =["Research Talk on AI", "Career Talk", "Global Days of Changemaking", "Research Forum", "Library Photo Exhibition"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(

      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    //padding: EdgeInsets.all(20),
                    height: 220.0,
                    child: Carousel(
                      dotSize: 5.0,
                      indicatorBgPadding: 0,
                      boxFit: BoxFit.cover,
                      images: [
                        AssetImage('assets/images/2.jpg'),
                        AssetImage('assets/images/cu_1.jpg'),
                        AssetImage('assets/images/hku.jpg'),
                        AssetImage('assets/images/hkust_1.jpg'),
                        AssetImage('assets/images/ou.png'),
                        AssetImage('assets/images/lingu_1.jpg'),
                        AssetImage('assets/images/bu_1.jpg')
                      ],
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 2000),
                    ),
                  ),
                  new SizedBox(
                    height: 1.0,
                  ),
                  Row(
                    children: <Widget>[
                      //Text(user)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:1.0),
                    child: Row(
                      children: <Widget>[
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Row(

                          children: <Widget>[
                            Container(

                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: RawMaterialButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EventAllPage(user: widget.user,)));
                                    }, child: new Icon(Icons.event,size: 30.0,color: Color(0xFF2E7D32),),
                                      shape: new CircleBorder(
                                        side: const BorderSide(
                                          color: Colors.black12
                                        )
                                      ),
                                      elevation: 10.0,
                                      fillColor: Colors.white,
                                    ),
                                    width: 65,
                                    height: 65,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:13.0),
                                    child: Text("Events",style: TextStyle(fontSize: 15),),
                                  )
                                ],
                              ),
                            ),
                            Container(

                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: RawMaterialButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsContent()));
                                    }, child: new Icon(Icons.new_releases,size: 30.0,color: Color(0xFF795548),),
                                      shape: new CircleBorder(
                                          side: const BorderSide(
                                              color: Colors.black12
                                          )
                                      ),
                                      elevation: 10.0,
                                      fillColor: Colors.white,
                                    ),
                                    width: 65,
                                    height: 65,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:13.0),
                                    child: Text("News",style: TextStyle(fontSize: 15),),
                                  )
                                ],
                              ),
                            ),
                            Container(

                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: RawMaterialButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PostHomePage()));
                                    }, child: new Icon(Icons.forum,size: 30.0, color: Color(0xFF009688),),
                                      shape: new CircleBorder(
                                          side: const BorderSide(
                                              color: Colors.black12
                                          )
                                      ),
                                      elevation: 10.0,
                                      fillColor: Colors.white,
                                    ),
                                    width: 65,
                                    height: 65,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:13.0),
                                    child: Text("Journal",style: TextStyle(fontSize: 15),),
                                  )
                                ],
                              ),
                            ),

                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                        SizedBox(height: 15,),
                        Row(

                          children: <Widget>[
                            Container(

                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: RawMaterialButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectLocationPage()));
                                    }, child: new Icon(Icons.local_dining,size: 30.0,color: Color(0xFF8bc34a)),
                                      shape: new CircleBorder(
                                          side: const BorderSide(
                                              color: Colors.black12
                                          )
                                      ),
                                      elevation: 10.0,
                                      fillColor: Colors.white,
                                    ),
                                    width: 65,
                                    height: 65,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:13.0),
                                    child: Text("Food",style: TextStyle(fontSize: 15),),
                                  )
                                ],
                              ),
                            ),
                            Container(

                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: RawMaterialButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => JobsAllPage()));
                                    }, child: new Icon(Icons.card_travel,size: 30.0,color: Color(0xFF546e7a),),
                                      shape: new CircleBorder(
                                          side: const BorderSide(
                                              color: Colors.black12
                                          )
                                      ),
                                      elevation: 10.0,
                                      fillColor: Colors.white,
                                    ),
                                    width: 65,
                                    height: 65,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:13.0),
                                    child: Text("Jobs",style: TextStyle(fontSize: 15),),
                                  )
                                ],
                              ),
                            ),
                            Container(

                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: RawMaterialButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LinksPage()));
                                    }, child: new Icon(Icons.link,size: 30.0,color: Color(0xFF006064),),
                                      shape: new CircleBorder(
                                          side: const BorderSide(
                                              color: Colors.black12
                                          )
                                      ),
                                      elevation: 10.0,
                                      fillColor: Colors.white,
                                    ),
                                    width: 65,
                                    height: 65,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:13.0),
                                    child: Text("Links",style: TextStyle(fontSize: 15),),
                                  )
                                ],
                              ),
                            ),

                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ],
                    ),
                  ),



                  new SizedBox(
                      height:5),
                  Padding(
                    padding: const EdgeInsets.only(left:15, right:15),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Icon(Icons.playlist_add_check),
                            new SizedBox(width: 5.0,),
                            new Text("REGISTERED EVENT", style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  new SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            child: GestureDetector(
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    image: new DecorationImage(
                                        image: new ExactAssetImage("assets/images/qr_code.jpg"),
                                        fit: BoxFit.cover, colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.darken))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.check_circle_outline, color: Colors.white,size: 30,),
                                        SizedBox(width: 5.0,),
                                        Text("Self Check-in", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => QRPage(user: widget.user,)));
                              },
                            ),
                            elevation: 5.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  new SizedBox(
                      height:30),
                  Padding(
                    padding: const EdgeInsets.only(left:15.0, right: 15.0),
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                            child: Row(
                              children: <Widget>[
                                new Icon(Icons.event),
                                new SizedBox(width: 5.0,),
                                new Text("UPCOMING", style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                              ],
                            )
                        ),
                         new Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  //print(UserManagement().UserName());
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EventAllPage(user: widget.user,)));
                                },
                                child: GestureDetector(
                                  onTap: (){

                                    main() async{
                                      print (await UserManagement().UserName());
                                    }
                                    main();
                                    UserManagement().UserName();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EventAllPage(user: widget.user,)));
                                  },
                                  child: Container(
                                      child: new Text("View All", style: new TextStyle(fontSize: 12.0, color: Colors.black),textAlign: TextAlign.end,)),
                                ),

                              )
                          ),

                      ],
                    ),
                  ),
                  new SizedBox(
                      height:15),
                  CarouselSlider(
                    enlargeCenterPage: true,
                    height: 230.0,
                    items: images.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            elevation: 2.0,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    //margin: EdgeInsets.symmetric(horizontal: 5.0),

                                    decoration: BoxDecoration(
                                        color: Colors.amber
                                    ),
                                    child: Image.network(i,fit: BoxFit.cover,),

                                  ),
                                ),
                                SizedBox(height: 8.0,),
                                Row(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top:3.0, left: 8.0, right: 8.0, bottom:10),
                                      child: Text(description[images.indexOf("$i")], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black54),),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height:50),


                ],


              )
          ),
        )
      ],
    );

  }

}


