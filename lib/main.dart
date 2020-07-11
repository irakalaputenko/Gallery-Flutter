import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  }
class _MyAppState extends State<MyApp> {

  // key = N7XT1UdPLGEOf5mvp7Hp8GU0N3dCJrpsCUcI-TGAwcE

  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchimages();
  }

  Future<String> fetchimages() async{
    var fetchdata = await http.get('https://api.unsplash.com/search/photos?'
        'per_page=30&client_id=N7XT1UdPLGEOf5mvp7Hp8GU0N3dCJrpsCUcI-TGAwcE&'
        'query=doberman');

    var jsondata = json.decode(fetchdata.body);

    setState(() {
      data=jsondata['results'];
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gallery",
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Gallery"),
        ) ,
        body: Builder(builder: (context)=>Swiper(
          itemBuilder: (BuildContext context, int index){
            return Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:40.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                      bottomLeft: Radius.circular(35.0),
                      bottomRight: Radius.circular(35.0),

                    ),
                    child: Image.network(
                      data[index]['urls']['small'],
                      fit: BoxFit.cover,
                      height: 500.0,
                    ),
                  ),
                ),

              ],

            );
          },
          itemCount: 10,
          autoplay: true,
          viewportFraction: 0.8,
          scale: 0.9,

        )
          ),
        backgroundColor: Colors.black,
      ),

    );
  }
}
