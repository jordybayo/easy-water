import 'dart:async';
import 'package:easywater/core/models/userInfo.dart';
import 'package:easywater/core/services/fileDatabase.dart';
import 'package:easywater/features/home/presentation/pages/home.dart';
import 'package:easywater/features/login/presentation/pages/register1.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  final UserInfos userInfos;
  SplashScreen(this.userInfos);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var fData = FileDatabase();

  startTimeout() {
    return Timer(Duration(seconds: 4), changeScreen);
  }

  changeScreen() async {
    List nextScreenValue = await fData.readDbFile(); // walktheough or login
    bool nextScreen;
    if (nextScreenValue[1] != 1) nextScreen = false;
    else nextScreen = true;
    print("the value of nextSceen Value $nextScreen");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          if(nextScreen == true){
            return Home(widget.userInfos);
          }
          else{
            return RegisterOne();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    // fData.writeDbFile(0, 0); // just for test purpose to to begin with walkthrough
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        //margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Padding(
          padding: const EdgeInsets.all(175.0),
          child: FlareActor("assets/animations/easy_water.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
              animation: 'Untitled'),
        )
      ),
    );
  }
}
