import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'news_page.dart';
import 'main.dart';
import 'home_page.dart';
import 'food_content.dart';
import 'jobs_page.dart';
import 'noti_page.dart';
import 'explore_page.dart';
import 'user_manage.dart';

class UserInfoPage1 extends StatefulWidget{
  const UserInfoPage1({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  @override
  UserInfoPage1State createState() => UserInfoPage1State();
}

class UserInfoPage1State extends State<UserInfoPage1>{


  int _currentIndex=0;
  Widget callPage(int currentIndex){
    switch(currentIndex){
      case 0: return HomeContent(user: widget.user,);
      case 1: return ExplorePage(user: widget.user,);
    case 2: return NotiPage(user: widget.user,);
      case 3: return UserInfoPage1(user: widget.user,);

      break;
      default:return HomeContent();
    }

  }




  @override
  Widget build(BuildContext context) {
    String username=UserManagement().name;
    print(username);
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Color(0xFFE8F5E9),
      body: Center(
        child: ListView(
          children: <Widget>[
            new SizedBox(
              height: MediaQuery.of(context).size.height/10,
            ),


            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: new DecorationImage(
                            image: new ExactAssetImage("assets/images/profile_man.jpg"),
                            fit: BoxFit.cover,
                            //colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
                            )
                      ),
                      width: 85,
                      height: 85,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Text("John Chan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:3.0),
                  child: Text("Male", style: TextStyle(fontSize: 18.0, color: Colors.black45),),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:20,left:20, right:20.0),
                  child: Card(
                    elevation: 5.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF90a4ae),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:30, bottom:30,left:30.0, right: 30),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.phone, color: Colors.white,),
                                SizedBox(width: 25.0,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("PHONE", style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 5.0,),
                                    Text("91456734",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: <Widget>[
                                Icon(Icons.mail,color: Colors.white),
                                SizedBox(width: 25.0,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("EMAIL", style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 5.0,),
                                    Text("${widget.user.email}",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: <Widget>[
                                Icon(Icons.school, color: Colors.white),
                                SizedBox(width: 25.0,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("UNIVERSITY", style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 5.0,),
                                    Text("HKU",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: <Widget>[
                                Icon(Icons.person, color: Colors.white),
                                SizedBox(width: 25.0,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("ROLE", style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 5.0,),
                                    Text("Student",style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,)
              ],
            ),




          ],
        ),
      )

    );
  }

  Future<void> getusername() async{

       // FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user)));
       UserManagement().getName(context);







  }

}





