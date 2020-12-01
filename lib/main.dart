import 'package:easywater/core/models/userInfo.dart';
import 'package:easywater/core/utils/const.dart';
import 'package:easywater/features/loadingscreen/presentation/pages/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  runApp(EasyWater());
}

class EasyWater extends StatelessWidget {
  // This widget is the root of your application.
  UserInfos userInfo;

  getData() async {
    final FirebaseUser user = (await FirebaseAuth.instance.currentUser().then((val) {
      print("1******************* + ${val.uid}");
      // return FirebaseDatabase.instance.reference().child('users').equalTo(val.uid);
    }).catchError((e) {
      print("2--------------- $e");
    })) ;
    print("3********************");
  }

  @override
  Widget build(BuildContext context) {
    getData().then((val){
      print(val.email);
      userInfo = new UserInfos(val.uid, val.userName, val.dateCreated, val.dialCode, val.phoneNumber, val.verificationCode,
          val.verificationID, val.displayLanguage, val.country, val.logged, val.water_flow);
    });
      //print("********* new userInfo: ${userInfo.uid}");
    return MaterialApp(
      title: 'Easy water',
      theme: Constants.lightTheme,
      home: SplashScreen(userInfo),
    );
  }

}
