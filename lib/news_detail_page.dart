import 'package:flutter/material.dart';
import 'dart:async';
import 'news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

Future<List<Article>> FetchArticleSource(String source) async{
  //final response = await http.get("https://newsapi.org/v2/top-headlines?sources=${source}&apiKey=ed320ea5b52a42a29dfe568783b12202");
  final response = await http.get("https://newsapi.org/v2/everything?sources=${source}&q=university%20OR%20music%20OR%20sports%20OR%20technology&apiKey=*your api key*");

  if (response.statusCode == 200){

    List articles = json.decode(response.body)["articles"];
    return articles.map((article) => new Article.fromJson(article)).toList();
  }
  else{
    throw Exception("Fail to Fetch Article");
  }

}


class NewsDetail extends StatefulWidget{
  final Source sources;

  NewsDetail({Key key, @required this.sources}): super(key: key);

  State<StatefulWidget> createState() => NewsDetailState();

}

class NewsDetailState extends State<NewsDetail> {

  var list_articles;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void initState(){
    refreshListArticle();

  }

  Future<Null> refreshListArticle() async {
    refreshKey.currentState?.show(atTop: false);

    setState(() {
      list_articles = FetchArticleSource(widget.sources.id);
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: Center(
        child: RefreshIndicator(
            key: refreshKey,
            child: FutureBuilder<List<Article>>(
                future: list_articles,
                builder: (context, snapshot){
                  if (snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  else if (snapshot.hasData){
                    List<Article> articles = snapshot.data;
                    return ListView(
                      children: articles.map((article) => GestureDetector(
                        onTap: (){
                          _launchUrl(article.url);
                        },
                        child: Card(
                          elevation: 5.0,
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                  colorFilter: new ColorFilter.mode(Colors.black54, BlendMode.dstIn),
                                  image: article.urlToImage != null? NetworkImage(article.urlToImage): ExactAssetImage("assets/images/newspaper.jpg"))
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 15.0, top:20.0, right:15.0, bottom: 20),
                                              child: Text("${article.title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
                                              ),

                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
                                        child: Text("${article.description}", style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 14.0),),

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:15.0,bottom: 10.0, left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(left: 8.0),
                                              child: Text("${article.publishedAt}", style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold, fontSize: 12.0),textAlign: TextAlign.right,),

                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                        ),
                      )).toList(),
                    );
                  }
                  return CircularProgressIndicator();

                }),
            onRefresh: refreshListArticle),

      ),
    );
  }




}

  _launchUrl(String url) async{
  if (await canLaunch(url)){
    await launch(url);
  }
  else{
    throw ("Could not  launch ${url}");
  }

}






