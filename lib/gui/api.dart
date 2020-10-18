import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Weather'),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Image.asset(
                'images/background.jpg',
                fit: BoxFit.fitHeight,
                width: 1000,
                height: 2800,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 180, top: 20),
              child: Image.asset('images/icon.png'),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 80),
              child: getDataWidget(),
            ),
          ],
        ));
  }

  Future<Map> getData() async {
    Response response = await get(
        'http://api.weatherstack.com/current?access_key=6a150d4c4d715172a3a187bbc6ebfdb1&query=New%20York');
    return json.decode(response.body);
  }

  Widget getDataWidget() {
    return FutureBuilder(
        future: getData(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${content['location']['name']}',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${content['current']['temperature']} °C',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'time: ${content['current']['observation_time']}',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

//Image.asset('images/background.jpg',fit: BoxFit.fitHeight,width: 1800,height: 2800,),
