import 'package:easywater/core/models/userInfo.dart';
import 'package:easywater/core/services/databaseHelperUserInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class RealtimeCRUDOps{
  final UserInfos userInfos;

  RealtimeCRUDOps(this.userInfos);

  static FirebaseDatabase _database = FirebaseDatabase.instance;

  static var _db = new DatabaseHelper();

  /*Query _userQuerry = _database
      .reference()
      .child("users")
      .orderByChild("phoneNumber")
      .equalTo("${_db.getUserPhone()}");*/

  addNewUserActivity() {
      _database.reference().child("users").child(userInfos.uid).set(userInfos.toMap());
  }

  updateUserActivity(){
    _database.reference().child("users").child(userInfos.uid).update(userInfos.toMap());
  }

  // Firebase get current uid
  getUid() {
    FirebaseAuth.instance.currentUser().then((val) {
      return val.uid;
    }).catchError((e) {
      print(e);
      return e;
    });
  }

  signOut(BuildContext context){
    FirebaseAuth.instance.signOut().then((action) {
      Navigator
          .of(context)
          .pushReplacementNamed('/landingpage');
    }).catchError((e) {
      print(e);
    });
  }

}
