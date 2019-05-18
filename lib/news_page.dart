import 'package:flutter/material.dart';
import 'dart:async';
import 'news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'news_detail_page.dart';

Future<List<Source>> FetchNewsSource() async{
  final response = await http.get("https://newsapi.org/v2/sources?language=en&apiKey=*api key*&sortBy=popularity");

  if (response.statusCode == 200){

    List sources = json.decode(response.body)["sources"];
    return sources.map((source) => new Source.fromJson(source)).toList();
  }
  else{
    throw Exception("Fail to Fetch News");
  }

}

class NewsContent extends StatefulWidget{

  State<StatefulWidget> createState() => NewsContentState();

}

class NewsContentState extends State<NewsContent>{

  var list_sources;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void initState(){
    super.initState();
    refreshListSource();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: Center(
        child: RefreshIndicator(
            key: refreshKey,
            child: FutureBuilder<List<Source>>(
              future: list_sources,
                builder: (context, snapshot){
                if (snapshot.hasError){
                  return Text("Error:,  ${snapshot.error}");
                }
                else if (snapshot.hasData){
                  List<Source> sources = snapshot.data;
                  return new ListView(
                    children: sources.map((source) => GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(sources: source)));
                      },
                      child: Card(
                        elevation: 5.0,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2.0),
                              width: 100.0,
                              height: 140.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/images/news_icon.png"),
                              ),

                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 12.0, right: 8.0),
                                          child: Text("${source.name}", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                                          
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0, right: 8.0, bottom: 8.0),
                                    child: Container(
                                      child: Text("${source.description}", style: TextStyle(fontSize: 14.0),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:8.0),
                                    child: Container(
                                      child: Text("Category: ${source.category}", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],

                        ),

                      ),
                    )).toList());

                }
                return CircularProgressIndicator();


                },
                )
            , onRefresh: refreshListSource),
      ),


    );
  }

  Future<Null> refreshListSource() async {
    refreshKey.currentState?.show(atTop: false);

    setState(() {
      list_sources = FetchNewsSource();
    });

    return null;
  }

}

