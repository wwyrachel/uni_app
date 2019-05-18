import 'package:flutter/material.dart';
import "home_page.dart";
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage1 extends StatefulWidget{
  @override
  LoginPageState createState() => new LoginPageState();
}


class LoginPageState extends State<LoginPage1>{
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.green),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top:0, bottom:0),
                    child: new Image.asset('assets/images/1.jpg', scale:5.0, height: 100,
                    )
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:8, bottom:60),
                  child: new Text("PolyU App", style: new TextStyle(fontSize:20.0),),
                )
              ],
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: new TextField(
                decoration: new InputDecoration(
                  labelText: "Email",
                ),

              ),
            ),
            new SizedBox(
              height:1.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: new TextField(
                obscureText: true,
                decoration: new InputDecoration(
                  labelText: "Password",
                ),

              ),
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:20, right: 5, top: 5),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                            color: Colors.red,borderRadius: new BorderRadius.circular(10.0)),
                        child: new Text("Login", style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:5, right: 20, top: 5),
                    child: new Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      child: new Text("Forget Password...", style: new TextStyle(fontSize: 12.0, color: Colors.black)),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:8),
                    child: new Text("Create a New Account", style: new TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold),),
                  ),
                ],
              ),
            )

          ],
        )
    );
  }
}
