import 'package:flutter/material.dart';
import 'explore_page.dart';
import 'user_manage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfoPage3 extends StatefulWidget{
  const UserInfoPage3({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;
  @override
  UserInfoPage3State createState() => UserInfoPage3State();
}

class UserInfoPage3State extends State<UserInfoPage3>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("yyy"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Raja'),
              accountEmail: new Text('testemail@test.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
            new ListTile(
              title: new Text('About Page'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ExplorePage()));
              },
            ),
            new ListTile(
              title: new Text("Admin page"),
              onTap: () {
                UserManagement().authorizeAccess(context);
              },
            ),
            new ListTile(
              title: new Text('Logout'),
              onTap: () {
                UserManagement().signOut();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Dashboard"),
      ),
    );
  }
}