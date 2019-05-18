import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'edit_event.dart';
import 'methods.dart';
import 'add_blank_event.dart';

class AddEventPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return AddEventPageState();
  }
}

class AddEventPageState extends State<AddEventPage> {
  String eventName;
  String eventLocation;
  Methods _methods = new Methods();

  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("events").getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddDetailEventPage(post: post,)));
  }





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: Container(
        child: FutureBuilder(
            future: getPosts(),
            builder: (_, snapshot){

              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else{

                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(


                            elevation: 5.0,
                            child: Container(
                              width: 200,


                              child: Column(
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      //new Container(

                                      Expanded(child: new Image.network(snapshot.data[index].data["imageURL"], height: 240, fit: BoxFit.cover,))

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
                                                child: new Text(snapshot.data[index].data["name"],
                                                  style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
                                              ),
                                              new Text("${snapshot.data[index].data["date"].toString()} ${snapshot.data[index].data["time"]}",style: TextStyle(color: Colors.grey),),
                                            ],
                                          ),
                                        ),

                                        new Icon(Icons.timer),
                                        new SizedBox(
                                          width: 10,
                                        ),
                                        new Text(snapshot.data[index].data["duration"].toString()+ " hr"),
                                      ],
                                    ),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: new Row(

                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top:20.0, left: 20, right: 5, bottom: 5),

                                          child: SizedBox(
                                              width: width-width/5,
                                              child: new Text(snapshot.data[index].data["description"], softWrap: true, textAlign: TextAlign.justify,)),

                                        )

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:5.0,left:20, right: 20, bottom:20),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            new Icon(Icons.school),
                                            new SizedBox(width: 5.0,),
                                            new Text(snapshot.data[index].data['host_dept'], style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            new Icon(Icons.local_offer),
                                            new SizedBox(width: 5.0,),
                                            new Text(snapshot.data[index].data['id'].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),




                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: (){

                                            AlertDialog dialog = new AlertDialog(
                                              title: new Row(
                                                children: <Widget>[
                                                  new Icon(Icons.warning),
                                                  new SizedBox(width: 7.0,),
                                                  new Text("Confirm")
                                                ],
                                              ),
                                              content: new Text("Are you sure to delete this item permanently?", style: TextStyle(fontSize: 20),),
                                              actions: <Widget>[
                                                new FlatButton(onPressed: (){
                                                  Firestore.instance.runTransaction((Transaction transaction) async{
                                                    DocumentSnapshot snapshot1=
                                                    await transaction.get(snapshot.data[index].reference);
                                                    await transaction.delete(snapshot1.reference);
                                                  });

                                                  //sleep(const Duration(seconds:3));
                                                  Navigator.pop(context);
                                                  AlertDialog dialog = new AlertDialog(
                                                    title: new Row(
                                                      children: <Widget>[
                                                        new Icon(Icons.thumb_up),
                                                        new SizedBox(width: 7.0,),
                                                        new Text("Successful")
                                                      ],
                                                    ),
                                                    content: new Text("Record has been deleted! Please refresh page!", style: TextStyle(fontSize: 20),),
                                                    actions: <Widget>[
                                                      new FlatButton(onPressed: (){


                                                        //sleep(const Duration(seconds:3));
                                                        Navigator.pop(context);




                                                      }, child: new Text("OK")),

                                                    ],
                                                  );
                                                  showDialog(context: context, child: dialog);




                                                }, child: new Text("Yes")),
                                                new FlatButton(onPressed: (){

                                                  //sleep(const Duration(seconds:3));
                                                  Navigator.pop(context);




                                                }, child: new Text("Cancel")),

                                              ],
                                            );
                                            showDialog(context: context, child: dialog);

                                            /*
                                            Firestore.instance.runTransaction((Transaction transaction) async{
                                              DocumentSnapshot snapshot1=
                                                  await transaction.get(snapshot.data[index].reference);
                                              await transaction.delete(snapshot1.reference);
                                            });
                                            */

                                          },
                                          child: Column(
                                            children: <Widget>[
                                              Icon(Icons.delete, color: Colors.blue,),
                                              SizedBox(height: 10,),
                                              Text("DELETE", style: TextStyle(color: Colors.blue),)
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            navigateToDetail(snapshot.data[index]);
                                          },
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => new EditDetailEventPage(
                                                EventName: snapshot.data[index].data["name"],
                                                EventDate: snapshot.data[index].data["date"].toString(),
                                                EventDes: snapshot.data[index].data["description"],
                                                EventHostDept: snapshot.data[index].data["host_dept"],
                                                EventID: snapshot.data[index].data["id"].toString(),
                                                EventLoc: snapshot.data[index].data["location"],
                                                EventTime: snapshot.data[index].data["time"],
                                                EventURL: snapshot.data[index].data["imageURL"],
                                                index: snapshot.data[index].reference,


                                              )));
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(Icons.edit, color: Colors.blue,),
                                                SizedBox(height: 10,),
                                                Text("EDIT", style: TextStyle(color: Colors.blue),)
                                              ],
                                            ),
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
                      );


                    });
              }
            }),
      ),
      floatingActionButton: new FloatingActionButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddBlankDetailEventPage()));
        //navigateToDetail();
        //Firestore.instance.collection("events").document().setData({"name":"123", "location":"abc"});
      },
      tooltip: "Add Event",
      child: new Icon(Icons.add),),
    );
  }


}



class AddDetailEventPage extends StatefulWidget{
   final DocumentSnapshot post;

   AddDetailEventPage({this.post});
  State<StatefulWidget> createState(){
    return AddDetailEventPageState();
  }
}

class AddDetailEventPageState extends State<AddDetailEventPage> {

  final TextEditingController _textEditingController= new TextEditingController();
  final TextEditingController _textEditingController1= new TextEditingController();
  final TextEditingController _textEditingController2= new TextEditingController();
  final TextEditingController _textEditingController3= new TextEditingController();
  final TextEditingController _textEditingController4= new TextEditingController();
  final TextEditingController _textEditingController5= new TextEditingController();
  final TextEditingController _textEditingController6= new TextEditingController();
  final TextEditingController _textEditingController7= new TextEditingController();

  bool _validateName= false;
  bool _validateDes= false;
  bool _validateLoc= false;
  bool _validateHostDept= false;
  bool _validateDuration= false;
  bool _validateID= false;
  bool _validateDate= false;
  bool _validateImageURL= false;

  String newName= "";
  String newDes="";
  String newLocation= "";
  String newID= "";
  String _dateText= "";
  String newDuration= "";
  String newHostDept= "";
  String newImage= "";
  String newTime="";

  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dueDate= DateTime.now();

  Future<Null> _selectDueDate(BuildContext context) async{
    final picked = await showDatePicker(context: context,
        initialDate: DateTime(2019), firstDate: DateTime(2019), lastDate: DateTime(2080));

    if (picked != null){
      setState(() {
        _dueDate= picked;
        _dateText = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async{
    final TimeOfDay picked_time = await showTimePicker(context: context, initialTime: new TimeOfDay.now());

    if (picked_time != null){
      print("picked");
      setState(() {
        _timeOfDay= picked_time;
        newTime = "${picked_time.hour}: ${picked_time.minute}";
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _dateText= "${_dueDate.day}-${_dueDate.month}-${_dueDate.year}";
    newTime="${_timeOfDay.hour}:${_timeOfDay.minute}";
  }


  void _addData(){
    Firestore.instance.runTransaction((Transaction transaction) async{
      CollectionReference reference = Firestore.instance.collection("events");
      await reference.add(
        {
          "name": newName,
          "duration": newDuration,
          "location": newLocation,
          "host_dept": newHostDept,
          "imageURL": "https://images.idgesg.net/images/article/2018/10/ai_artificial-intelligence_circuit-board_circuitry_mother-board_nodes_computer-chips-100777423-large.jpg",
          "id": newID,
          "description": newDes,
          "date": _dateText,
          "time": newTime
        }
      );
    }
    );
    Navigator.pop(context);
  }



  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFdcedc8),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.note_add, size: 30,),
                        SizedBox(width: 8.0,),
                        Text("Create an event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController1,
                            keyboardType: TextInputType.number,
                            onChanged: (String str){
                              setState(() {
                                newID= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.local_offer),
                                hintText: widget.post.data["id"],
                              labelText: "Event ID",
                              errorText: _validateID? "Event ID cannot be empty and itmust be an integer!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            onChanged: (String str){
                              setState(() {
                                if (str.isEmpty){
                                  _validateName= true;
                                }else{
                                  newName= str;
                                }

                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.title),
                              hintText: widget.post.data["name"],
                              labelText: "Event Name",
                              errorText: _validateName? "Event name cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 13.0,),
                        Icon(Icons.access_time, color: Colors.black54,),
                        Expanded(
                          child: FlatButton(
                            onPressed: (){
                              _selectTime(context);
                            },
                            child: Text(newTime),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 13.0,),
                        Icon(Icons.event, color: Colors.black54),
                        Expanded(
                          child: FlatButton(
                            onPressed: (){
                              _selectDueDate(context);
                            },
                            child: Text(_dateText),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController3,
                            keyboardType: TextInputType.number,
                            onChanged: (String str){
                              setState(() {
                                newDuration= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.timer),
                                hintText: widget.post.data["duration"].toString(),
                                labelText: "Event Duration",
                              errorText: _validateDuration? "Event duration cannot be empty and itmust be an integer!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController4,
                            onChanged: (String str){
                              setState(() {
                                newDes= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.subject),
                                hintText: widget.post.data["description"].toString(),
                                labelText: "Event Description",
                              errorText: _validateDes? "Event description cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController5,
                            onChanged: (String str){
                              setState(() {
                                if (str.isEmpty== true){

                                }
                                newHostDept= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.school),
                                hintText: widget.post.data["host_dept"],
                              labelText: "Host Department",
                              errorText: _validateHostDept? "Host Department cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _textEditingController6,
                            onChanged: (String str){
                              setState(() {
                                if (str.isEmpty== true){

                                }
                                newLocation= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_on),
                                hintText: widget.post.data["location"],
                                labelText: "Event Location",
                              errorText: _validateLoc? "Event location cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0, left:15, right: 15, bottom:5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(

                            controller: _textEditingController7,
                            onChanged: (String str){
                              setState(() {
                                newImage= str;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.image),
                                hintText: widget.post.data["imageURL"],
                                labelText: "Event Image",
                              errorText: _validateImageURL? "Event image cannot be empty!": null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                        icon: Icon(Icons.close),
                          onPressed: (){
                          Navigator.pop(context);
                          },
                      ),
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: (){
                            setState(() {
                              /*
                              if (_textEditingController1.text.isEmpty){
                                _validateID=true;
                              }else if (_textEditingController.text.isEmpty){
                                _validateName=true;
                              }else if (_textEditingController2.text.isEmpty){
                                _validateDate=true;
                              }else if (_textEditingController3.text.isEmpty){
                                _validateDuration=true;
                              }else if (_textEditingController4.text.isEmpty){
                                _validateDes=true;
                              }else if (_textEditingController5.text.isEmpty){
                                _validateHostDept=true;
                              }else if (_textEditingController6.text.isEmpty){
                                _validateLoc=true;
                              }else if (_textEditingController7.text.isEmpty){
                                _validateImageURL=true;
                              }else{
                                _addData();
                              }
                              */
                              _addData();

                            });
                            //_addData();
                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


/*
hild: ListTile(
          leading: Icon(Icons.title),
          title: Text(widget.post.data["name"]),
          subtitle: Text(widget.post.data["description"]),
 */