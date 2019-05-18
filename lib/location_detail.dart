import 'package:flutter/material.dart';
import 'location_model.dart';
import 'location_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class PlaceDetailPage extends StatefulWidget {
  final String _place_id;
  PlaceDetailPage(this._place_id);
  @override
  State createState() => new PlaceDetailState();
}

class PlaceDetailState extends State<PlaceDetailPage> {
  @override
  Widget build(BuildContext context) {
    if (_place == null) {
      return new Material(
          color: Colors.greenAccent,
          child: new Scaffold(
              backgroundColor: Color(0xFFE8F5E9),
              body: new Container(
                child: new Center(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: new CircularProgressIndicator(),
                    )),
              )));
    }
    return new Material(
        color: Colors.greenAccent,
        child: new Scaffold(
            backgroundColor: Color(0xFFE8F5E9),
            body: new SingleChildScrollView(

              child:
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new SizedBox(height: 60,),
                    new Container(
                      width: 300,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.local_cafe, size: 30,),
                          SizedBox(
                            width: 250,
                              child: Text(_place.name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                softWrap: true, textAlign: TextAlign.center,))
                        ],
                      ),
                    ),
                    new Divider(
                      //color: Colors.green,
                      height: 30.0,
                    ),
                    Card(
                      elevation: 3.0,
                      child: Container(


                        child: Column(
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //new Container(


                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20, right:20, top:20, bottom:12),
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          child: Row(
                                            children: <Widget>[
                                              new Row(
                                                children: <Widget>[
                                                  Icon(Icons.location_on),
                                                  SizedBox(width: 5,),
                                                  new Text("Address",
                                                    style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: new Row(

                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30, bottom: 20.0, top:20),

                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                  width: 230,
                                                  child: new Text(_place.formatted_address, softWrap: true,)),
                                              GestureDetector(
                                                  onTap: (){
                                                    Share.share("Check out the restaurant: ${_place.name}. It's very close to the university!! Detail please call: ${_place.international_phone_number}");
                                                  },
                                                  child: Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Icon(Icons.share, color: Colors.blue),
                                                        SizedBox(height: 10.0,),
                                                        Text("SHARE", style: TextStyle(color: Colors.blue),)
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),


                                ],
                              ),
                            )

                            //ListTile(
                            //  title:  Text(snapshot.data[index].data["name"], style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                            //),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      child: Container(


                        child: Column(
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //new Container(


                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20, right:20, top:20, bottom:12),
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          child: Row(
                                            children: <Widget>[
                                              new Row(
                                                children: <Widget>[
                                                  Icon(Icons.access_time),
                                                  SizedBox(width: 5,),
                                                  new Text("Opening Hours",
                                                    style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: new Row(

                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30, bottom: 20.0, top:20),

                                    child: SizedBox(
                                        width: 280,
                                        child: new Text( _place.weekday_text.toString().replaceAll("]", "").replaceAll("[", "").replaceAll(",", "\n").replaceAll("M", " M"), softWrap: true,)),

                                  )

                                ],
                              ),
                            )

                            //ListTile(
                            //  title:  Text(snapshot.data[index].data["name"], style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                            //),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 3.0,
                      child: Container(


                        child: Column(
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //new Container(


                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20, right:20, top:20, bottom:12),
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: new Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          child: Row(
                                            children: <Widget>[
                                              new Row(
                                                children: <Widget>[
                                                  Icon(Icons.phone_iphone),
                                                  SizedBox(width: 5,),
                                                  new Text("Phone Number",
                                                    style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: new Row(

                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30, bottom: 20.0, top:20),

                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                            width: 230,
                                            child: new Text(_place.international_phone_number, softWrap: true,)),
                                        GestureDetector(
                                          onTap: (){
                                            launch("tel://${_place.international_phone_number}");
                                          },
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(Icons.phone, color: Colors.blue),
                                                  SizedBox(height: 10.0,),
                                                  Text("CALL", style: TextStyle(color: Colors.blue),)
                                                ],
                                              ), )),

                                      ],
                                    ),

                                  )

                                ],
                              ),
                            ),



                            //ListTile(
                            //  title:  Text(snapshot.data[index].data["name"], style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                            //),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ));
  }

  PlaceDetail _place;
  @override
  void initState() {
    super.initState();

    LocationService.get().getPlace(widget._place_id).then((data) {
      setState(() {
        _place = data;
      });
    });
  }

  getCard(String header, String content, IconData iconData) {
    return new Card(
        color: Colors.white,
        child: new Container(
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text(header,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0))

                    ,

                    new Icon(iconData,color: Colors.green,)
                  ],
                )
                ,
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: new Text(content, textAlign: TextAlign.start),
                )
              ],
            ),
          ),
        ));
  }
}

/*
Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              Text("Address")
                            ],
                          ),
 */