import 'package:flutter/material.dart';
import "login_page.dart";
import 'login_page_2.dart';
import 'explore_page.dart';

void main () {
  runApp(new MaterialApp(
      home: new MyHomePage(),
  ));
}


class MyHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Color(0xFFc5e1a5),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(

                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top:0.0),
                        child: Image.asset('assets/images/uni_logo.png', scale:2, height: 200,
                        ),
                      ),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:0, bottom:180),
                      child: new Text("UNI APP", style: new TextStyle(fontSize:30.0, color: Colors.white, fontWeight: FontWeight.bold),),
                    )
                  ],
                ),

                new Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:35, right:35, bottom:0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage2()));
                          },
                          child: new Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: 50.0,
                              decoration: new BoxDecoration(
                                  color: Color(0xFF8d6e63), borderRadius: new BorderRadius.circular(1.0)),
                              child: new Text("SIGN IN", style: new TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))
                          ),
                        ),
                      ),
                    ),

                  ],

                ),






              ]



          )
      ),
    );
  }

}


