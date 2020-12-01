import 'package:easywater/core/models/userInfo.dart';
import 'package:easywater/features/buyWater/presentation/pages/buyWater.dart';
import 'package:easywater/features/home/presentation/widgets/textstyle.dart';
import 'package:easywater/features/nfc_tags/presentation/pages/write_flow_to_nfc.dart';
import 'package:easywater/features/walkthrough/presentation/pages/walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  final UserInfos userInfos;
  Home(this.userInfos);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                'assets/img/umbrella.png',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),
            new Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
              child: new Text(
                "Douala",
                style: cityStyle(),
              ),
            ),
            new Container(
              alignment: Alignment.topRight,
              child: new Image.asset("assets/img/light_rain.png"),
            ),
            //Container of temparature
            new Container(
              alignment: Alignment.center,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      "15 C",
                      style: new TextStyle(
                          fontSize: 45.9,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: new ListTile(
                      title: new Text(
                        "Humidity: 140 \n"
                        "Min: 100 C\n"
                        "Max: 200 C",
                        style: extraData(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(80),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[

                  SizedBox(height: 150,),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text("buy Water"),
                      color: Colors.deepOrange,
                    ),
                    onDoubleTap: () => goToBuyWaterFlow(),
                  ),
                  SizedBox(height: 150,),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text("tags"),
                      color: Colors.blue,
                    ),
                    onDoubleTap: () => goToWriteFlowToNFCTagPage(),
                  ),
                  SizedBox(height: 150,),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text("easy water"),
                      color: Colors.yellow,
                    ),
                    onDoubleTap: () => {},
                  ),
                  SizedBox(height: 150,),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text("settings"),
                      color: Colors.green,
                    ),
                    onDoubleTap: () => {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future goToWriteFlowToNFCTagPage() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return WriteFlowToNFCTag();
    }));
  }

  Future goToBuyWaterFlow() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return BuyWater(widget.userInfos);
        }));
  }
}
