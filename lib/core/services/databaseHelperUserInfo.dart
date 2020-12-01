import 'dart:async';
import 'package:easywater/core/models/userInfo.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final DatabaseHelper _dbHelper = DatabaseHelper._internal();
  final String tableName = "userInfo";
  final String id = "id";
  final String userName = "userName";
  final String dateCreated = "dateCreated";
  final String dialcode = "dialcode";
  final String phonenumber = "phonenumber";
  final String verificationCode = "verificationCode";
  final String verificationID = "verificationID";
  final String displaylanguage = "displaylanguage";
  final String logged = "logged";
  final String darktheme = "darktheme";
  final String country = "country";
  double waterFlow = 0.0;
  static Database _db;

  DatabaseHelper._internal();

  factory DatabaseHelper(){
    return _dbHelper;
  }

  //Valide pour toujour
  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "__db__.db";
    var __db__ = await openDatabase(path, version: 1, onCreate: _createDb);
    return __db__;
  }

  Future<Database> get db async {
    if(_db == null){
      _db = await initializeDb();
    }
    return _db;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute(
        "CREATE TABLE $tableName($id INTEGER PRIMARY KEY, $userName TEXT, $dateCreated TEXT, $dialcode TEXT, $phonenumber TEXT,  $verificationCode TEXT,  $verificationID TEXT, $country TEXT, $displaylanguage TEXT, $logged INTEGER, $darktheme INTEGER, $waterFlow REAL)"
    );
  }

  Future<int> insertUserInfo(UserInfos userInfos) async {
    try {
      deleteUserInfos(userInfos.id);
    } catch (e) {
      print("Not user");
    }
    Database db = await this.db;
    var result = await db.insert("$tableName", userInfos.toMap());
    return result;
  }



  Future<List> getUsersInfo() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tableName");
    return result;
  }

  Future<List> getUsersInfoPhoneDetails() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT dialcode, phonenumber FROM $tableName");
    return result;
  }

  Future<List> getUserPhone(Future<Database> db) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT phonenumber FROM $tableName");
    return result;
  }

  Future<List> getUserID(Future<Database> db) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT uid FROM $tableName");
    return result;
  }

  Future<bool> check() async{
    var result = await getUsersInfo();
    int count = result.length;
    if(count >= 1){
      return false;
    }else{
      return true;
    }
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tableName")
    );
    return result;
  }

  Future<int> updateUser(UserInfos userInfos) async {
    print('updated fav food');
    var dbClient = await db;
    return await dbClient.rawUpdate(
        'UPDATE $tableName SET '
            '$userName = \'${userInfos.userName}\''
            '$dateCreated = \'${userInfos.userName}\''
            '$dialcode = \'${userInfos.userName}\''
            '$phonenumber = \'${userInfos.userName}\''
            '$verificationCode = \'${userInfos.userName}\''
            '$verificationID = \'${userInfos.userName}\''
            '$displaylanguage = \'${userInfos.userName}\''
            '$logged = \'${userInfos.userName}\''
            '$darktheme = \'${userInfos.userName}\''
            '$country = \'${userInfos.userName}\''
            '$waterFlow = \'${userInfos.waterFlow}\''
            ' WHERE $id = ${userInfos.id}'
    );
  }

  Future<int> updateUserInfos(UserInfos userInfos) async {
    var db = await this.db;
    var result = await db.update(
        tableName, userInfos.toMap(),
        where: "$id = ?",
        whereArgs: [userInfos.id]
    );
    return result;
  }

  Future<int> deleteUserInfos(int idUser) async{
    var db = await this.db;
    var result = await db.rawDelete("DELETE FROM $tableName WHERE $id = $idUser");
    return result;
  }

}
