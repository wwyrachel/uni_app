import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'sign_up.dart';
import 'package:flutter/animation.dart';
import 'user_manage.dart';

class LoginPage2 extends StatefulWidget{
  @override
  _loginPageState createState() => new _loginPageState();
}

class _loginPageState extends State<LoginPage2> with SingleTickerProviderStateMixin{
  Animation animation;
  AnimationController animationController;
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState(){
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);

    animation = Tween(begin: -0.5, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    animationController.forward();
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
      content: new Text("Email or password is not valid! Please try again!", style: TextStyle(fontSize: 20),),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          Navigator.pop(context);
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
      builder: (BuildContext context, Widget child){
        return Scaffold(
          backgroundColor: Color(0xFFc5e1a5),
          resizeToAvoidBottomPadding: false,
          body: Transform(
            transform: Matrix4.translationValues(animation.value* 300, 0.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    new SizedBox(
                      height:50.0,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top:0, bottom:0),
                            child: new Image.asset('assets/images/uni_logo_black.png', scale:3.0, height: 80,
                            )
                        )
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:8, bottom:30),
                          child: new Text("UNI APP", style: new TextStyle(color: Colors.black,fontSize:20.0, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:30.0, right:30),
                      child: new TextFormField(
                        validator: (input){
                          if (input.isEmpty){
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
                      padding: const EdgeInsets.only(top: 10,left: 30, right: 30, bottom: 40),
                      child: new TextFormField(
                        obscureText: true,
                        validator: (input){
                          if (input.length < 6){
                            return "Please type a password";
                          }
                        },
                        onSaved: (input) => _password = input,
                        decoration: InputDecoration(
                          labelText: "Passowrd",
                        ),

                      ),
                    ),
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 40,
                      buttonColor: Color(0xFF8d6e63),
                      child: new RaisedButton(
                        onPressed: signIn,
                        child: Text("LOGIN", style: new TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:250),
                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          child: new Text("", style: new TextStyle(fontSize: 15.0)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom:8),
                            child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                },
                                child: Container(
                                    child: new Text("Create a New Account", style: new TextStyle(color: Colors.white,fontSize: 20.0, fontWeight:FontWeight.bold),
                                    ))
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        );
      },

    );
  }

  Future<void> signIn() async{
    print("yes");
    final formState = _formKey.currentState;
    print (formState);
    if (formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user)));
        UserManagement().authorizeAccess(context);
        print("logined");

      }catch(e){
        print(e.message);
        print("cannot login");
        _showErrorAlert();
      }

    }
  }

  Future<void> getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }
}

