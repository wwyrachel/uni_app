import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'post_models.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return LinksPageState();
  }
}

class LinksPageState extends State<LinksPage>{
  FirebaseDatabase _database = FirebaseDatabase.instance;



  var images_1= [
  "assets/images/2.jpg",
  "assets/images/1.jpg",
  "assets/images/hku.jpg",
  "assets/images/hkust.jpg",
  "assets/images/ou.png"
  ];


  var images =["https://www.thebalance.com/thmb/JyaUrq-ucrDj1ZQmz_lMZj5V0jY=/3870x2575/filters:fill(auto,1)/Financial-Ratio-Categories-56a091f03df78cafdaa2d0d5.jpg",
  "https://www.lifechangestrust.org.uk/sites/default/files/jobs.jpg",
  "https://dingo.care2.com/pictures/greenliving/1422/1421908.large.jpg",
  "https://englishlive.ef.com/blog/wp-content/uploads/sites/2/2013/06/black-and-white-dictionary.jpg",
    "https://media.lifehack.org/wp-content/uploads/2008/07/calendar-740x416.jpeg",
    "https://scottamyx.com/wp-content/uploads/2018/04/Travel.jpg"
  ];

  var description =["Financial Assistance", "Job Board", "Money Management", "Dictionary", "Calender", "Travel"];
  var rating = ["3", "5", "4", "3", "5", "2"];





  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return new Scaffold(
      backgroundColor: Color(0xFFE8F5E9),

      body:
      Container(
        color: Color(0xFFE8F5E9),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon (Icons.insert_link, size: 30,),
                SizedBox(width: 10,),

                Text("USEFUL LINKS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CarouselSlider(items: images.map((i){
              return Builder(
                builder: (BuildContext context){
                  return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: height-238,
                                width: double.infinity,
                                 child: Image.network(i,fit: BoxFit.cover,),
                              ),
                              SizedBox(height: 8.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(description[images.indexOf("$i")], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: stars_draw(int.parse(rating[images.indexOf("$i")])),
                                      )
                                    ],
                                  )

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      if (images.indexOf("$i") == 0) {
                                        _launchUrl("https://www.wfsfaa.gov.hk/sfo/en/index.htm");
                                      }
                                      else if (images.indexOf("$i") == 1){
                                        _launchUrl("https://www.jijis.org.hk/");
                                      }
                                      else if (images.indexOf("$i") == 2){
                                        _launchUrl("https://www.thechinfamily.hk/web/en/tertiary-student/");
                                      }
                                      else if (images.indexOf("$i") == 3){
                                        _launchUrl("https://dictionary.cambridge.org/dictionary/english/");
                                      }
                                      else if (images.indexOf("$i") == 4){
                                        _launchUrl("https://www.timeanddate.com/calendar/?country=42");
                                      }
                                      else if (images.indexOf("$i") == 5){
                                        _launchUrl("https://www.trivago.hk/en?sLanguageLocale=UK");
                                      }

                                    },
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text("GO TO WEBSITE", style: TextStyle( fontSize: 15, color: Colors.blueGrey),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("${rating[images.indexOf("$i")]} Stars")
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          //decoration: BoxDecoration(
                           // color: Colors.blue
                          //),
                          //child: Image.network(i,fit: BoxFit.cover,),



                  );
                },
              );
            }).toList(),
              height: height-95,
              autoPlay: false,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            )

            //Text("FORUM", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),






          ],
        ),
      ),




    );
  }

  Widget stars_draw( int number){
    if (number ==2){
      return new Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),

        ],
      );
    }
    else if (number ==3){
      return new Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),

        ],
      );
    }
    else if (number ==4){
      return new Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),

        ],
      );
    }
    else if (number ==5){
      return new Row(
        children: <Widget>[
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),
          Icon(Icons.star, color: Colors.yellow,size: 20,),

        ],
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


}