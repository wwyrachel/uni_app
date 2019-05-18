import 'package:flutter/material.dart';
import 'location_detail.dart';
import 'location_model.dart';
import 'location_service.dart';


class OUPlacesPage extends StatefulWidget {
  @override
  State createState() => new OUPlacestate();
}

class OUPlacestate extends State<OUPlacesPage> {

  String _currentPlaceId;
  @override
  Widget build(BuildContext context) {

    onItemTapped= ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new PlaceDetailPage(_currentPlaceId)));

    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body:_createContent(),
    );
  }
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _createContent() {

    if(_places == null){
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    else{

      return new ListView(

        children: _places.map((f){
          return new Card(
            elevation: 3.0,
            child: new ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top:8.0, bottom: 5.0),
                  child: f.name != null? new Text(f.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),) : new Text("No Data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                leading: new Image.network(f.icon),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: f.vicinity != null? new Text(f.vicinity) : new Text("No Data"),
                ),
                trailing: new Column(
                  children: <Widget>[
                    new Icon(Icons.star_border, color: Colors.yellowAccent,),
                    f.rating != null? new Text(f.rating) : new Text("No Data"),
                  ],
                ),
                onTap: (){
                  _currentPlaceId = f.id;
                  // onItemTapped();
                  handleItemTap(f);
                }
            ),
          );
        }).toList(),

      );
    }
  }
  List<PlaceDetail> _places;
  @override
  void initState() {
    super.initState();
    if (_places == null) {
      LocationService.get().getNearbyPlaces_ou().then((data) {
        this.setState(() {
          _places = data;
        });
      });
    }

    //print("count: "+_places.length.toString());
  }

  handleItemTap(PlaceDetail place){

    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=>new PlaceDetailPage(_currentPlaceId)));
  }

  VoidCallback onItemTapped;
}