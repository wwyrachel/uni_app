import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QRPage extends StatefulWidget{
  const QRPage({
    Key key,
    this.user}
      ): super(key:key);
  final FirebaseUser user;


  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage>{



  @override
  Widget build(BuildContext context) {
    //String ccc= widget.user.email;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return AspectRatio(
      aspectRatio: 100/100,
      child: new Scaffold(

          backgroundColor: Color(0xFFE8F5E9),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 90,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                elevation: 5.0,
                child: Container(
                    width: 100,
                    height: height/2,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new BarCodeImage(data: "${widget.user.email}", codeType: BarCodeType.Code128, lineWidth: 1,barHeight: 70.0,hasText: true,),
                          ],
                        ),
                        new SizedBox(height: 10,),
                        new Divider(color: Colors.black,),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new QrImage(data: "${widget.user.email}", size: width/2,)
                          ],
                        )


                      ],
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:35.0, right: 30.0, top: 25),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.sentiment_very_satisfied),
                      SizedBox(width: 5.0,),
                      Text("Show this to staff for quick registeration")
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.warning, size: 30,),
                      SizedBox(width: 5.0,),
                      Text("Use for registeration only!")
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}





