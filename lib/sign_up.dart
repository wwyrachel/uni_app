import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'login_page_2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';

class SignUp extends StatefulWidget{
  @override
  SignUpState createState() => new SignUpState();
}

class SignUpState extends State<SignUp> with SingleTickerProviderStateMixin{
  String _text;
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Animation animation;
  AnimationController animationController;

  void initState(){
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = Tween(begin: -0.5, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    animationController.forward();
  }


  void _showAlert(){

    AlertDialog dialog = new AlertDialog(
      title: new Row(
        children: <Widget>[
          new Icon(Icons.thumb_up),
          new SizedBox(width: 7.0,),
          new Text("Successful")
        ],
      ),
      content: new Text("Admin will contact you once your identity is verified!", style: TextStyle(fontSize: 20),),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage2()));
        }, child: new Text("OK"))
      ],
    );
    showDialog(context: context, child: dialog);
  }

  void _showErrorAlert(){

    AlertDialog dialog = new AlertDialog(
      title: new Row(
        children: <Widget>[
          new Icon(Icons.warning),
          new SizedBox(width: 7.0,),
          new Text("Error")
        ],
      ),
      content: new Text("Email has been registered. Please use another email!", style: TextStyle(fontSize: 20),),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
        }, child: new Text("OK"))
      ],
    );
    showDialog(context: context, child: dialog);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          backgroundColor: Color(0xFFc5e1a5),
          resizeToAvoidBottomPadding: false,
          body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  new SizedBox(
                    height: 50.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 0, bottom: 0),
                          child: new Image.asset(
                            'assets/images/uni_logo_black.png', scale: 3.0,
                            height: 80,
                          )
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 30),
                        child: new Text("UNI APP", style: new TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: new TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return "Please type an email";
                        }
                      },
                      onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                          labelText: "Email"
                      ),
                      //obscureText: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 30.0, right: 20, bottom: 40),
                    child: new TextFormField(
                      obscureText: true,
                      validator: (input) {
                        if (input.length < 6) {
                          return "Please type a password";
                        }
                      },
                      onSaved: (input) => _password = input,
                      decoration: InputDecoration(
                          labelText: "Passowrd"
                      ),

                    ),
                  ),
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 40,
                    buttonColor: Color(0xFF8d6e63),
                    child: new RaisedButton(
                      onPressed: signUp,
                      child: Text("CREATE ACCOUNT", style: new TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),),
                    ),
                  ),

                ],
              )),
        );

      },
    );
  }

  Future<void> signUp() async{
    print("yes");
    final formState = _formKey.currentState;
    print (formState);
    if (formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        user.sendEmailVerification();

        _showAlert();
        //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage2()));
        print("logined");

      }catch(e){
        _showErrorAlert();
        print(e.message);
        print("cannot login");
      }

    }
  }
}