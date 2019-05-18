import 'package:http/http.dart' as http;
import 'location_model.dart';
import 'dart:async';
import 'dart:convert';

class LocationService {
  static final _locationService = new LocationService();

  static LocationService get() {
    return _locationService;
  }

  static String polyu_gps = "22.304165,114.179106";
  static String cu_gps = "22.418498326,114.204074184";
  static String hku_gps = "22.283832198,114.135999456";
  static String hkust_gps = "22.3375,114.263";
  static String bu_gps = "22.33666532,114.175665964";
  static String ou_gps = "22.3162,114.18";
  static String lingu_gps = "22.41,113.983";
  static String syu_gps = "22.2862,114.198";


  final String detailUrl =
      "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4&placeid=";

  Future<List<PlaceDetail>> getNearbyPlaces() async {

    final String url =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${polyu_gps}&radius=1500&type=cafe&region=%22HK%22&Rankby=prominence&key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4";

  var reponse = await http.get(url, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["results"];
    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"],
        f["icon"], f["rating"].toString(), f["vicinity"])));

    return places;
  }

  Future<List<PlaceDetail>> getNearbyPlaces_cu() async {

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${cu_gps}&radius=1500&type=cafe&region=%22HK%22&Rankby=prominence&key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4";

    var reponse = await http.get(url, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["results"];
    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"],
        f["icon"], f["rating"].toString(), f["vicinity"])));

    return places;
  }

  Future<List<PlaceDetail>> getNearbyPlaces_hku() async {

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${hku_gps}&radius=1500&type=cafe&region=%22HK%22&Rankby=prominence&key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4";

    var reponse = await http.get(url, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["results"];
    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"],
        f["icon"], f["rating"].toString(), f["vicinity"])));

    return places;
  }

  Future<List<PlaceDetail>> getNearbyPlaces_hkust() async {

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${hkust_gps}&radius=1500&type=cafe&region=%22HK%22&Rankby=prominence&key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4";

    var reponse = await http.get(url, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["results"];
    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"],
        f["icon"], f["rating"].toString(), f["vicinity"])));

    return places;
  }

  Future<List<PlaceDetail>> getNearbyPlaces_bu() async {

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${bu_gps}&radius=1500&type=cafe&region=%22HK%22&Rankby=prominence&key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4";

    var reponse = await http.get(url, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["results"];
    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"],
        f["icon"], f["rating"].toString(), f["vicinity"])));

    return places;
  }

  Future<List<PlaceDetail>> getNearbyPlaces_syu() async {

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${syu_gps}&radius=1500&type=cafe&region=%22HK%22&Rankby=prominence&key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4";

    var reponse = await http.get(url, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["results"];
    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"],
        f["icon"], f["rating"].toString(), f["vicinity"])));

    return places;
  }

  Future<List<PlaceDetail>> getNearbyPlaces_lingu() async {

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lingu_gps}&radius=1500&type=cafe&region=%22HK%22&Rankby=prominence&key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4";

    var reponse = await http.get(url, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["results"];
    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"],
        f["icon"], f["rating"].toString(), f["vicinity"])));

    return places;
  }

  Future<List<PlaceDetail>> getNearbyPlaces_ou() async {

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${ou_gps}&radius=1500&type=cafe&region=%22HK%22&Rankby=prominence&key=AIzaSyBPVP31QN5tDhXKE2UKREbKw0L-CxhEhI4";

    var reponse = await http.get(url, headers: {"Accept": "application/json"});

    List data = json.decode(reponse.body)["results"];
    var places = <PlaceDetail>[];
    data.forEach((f) => places.add(new PlaceDetail(f["place_id"], f["name"],
        f["icon"], f["rating"].toString(), f["vicinity"])));

    return places;
  }

  Future getPlace(String place_id) async {
    var response = await http
        .get(detailUrl + place_id, headers: {"Accept": "application/json"});
    var result = json.decode(response.body)["result"];

    //print(result["opening_hours"]["weekday_text"]);


    //print("xxx"+result["formatted_phone_number"]);


    List<String> weekdays = [];

    if (result["opening_hours"] == null)
      weekdays=[""];

    if (result["opening_hours"] != null)
      weekdays= [result["opening_hours"]["weekday_text"].toString()];





    //result["opening_hours"]=4;
    //weekdays=["yes","yes"];
    //weekdays=[ result["opening_hours"]["weekday_text"].toString()];

    return new PlaceDetail(
        result["place_id"],
        result["name"],
        result["icon"],
        result["rating"].toString(),
        result["vicinity"],
        result["formatted_address"],
        result["international_phone_number"],
        weekdays);
  }

}