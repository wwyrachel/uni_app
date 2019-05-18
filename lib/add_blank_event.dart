import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:share/share.dart';
import 'methods.dart';


class AddBlankDetailEventPage extends StatefulWidget{

  State<StatefulWidget> createState(){
    return AddBlankDetailEventPageState();
  }
}

class AddBlankDetailEventPageState extends State<AddBlankDetailEventPage> {

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
      backgroundColor: Color(0xFFE8F5E9),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.library_add, size: 30,),
                        SizedBox(width:8.0),
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
                        Icon(Icons.event, color: Colors.black54,),
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