import 'package:easywater/core/services/databaseHelperUserInfo.dart';
import 'package:easywater/core/services/fileDatabase.dart';
import 'package:easywater/core/services/realtimedb_helper.dart';
import 'package:easywater/core/utils/appText.dart';
import 'package:easywater/core/models/userInfo.dart';
import 'package:easywater/features/walkthrough/presentation/pages/walkthrough.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'avatar.dart';
import 'package:flutter/material.dart';

class RegisterThree extends StatefulWidget {
  final UserInfos userInfos;

  RegisterThree(this.userInfos);

  @override
  State<StatefulWidget> createState() => new _RegisterThreeState();
}

class _RegisterThreeState extends State<RegisterThree> {
  var fData = FileDatabase();
  List<UserInfos> userInfos;
  UserInfos userInfo;
  int count;

  void getData(){
    final dbFuture = db.initializeDb();
    //load db
    dbFuture.then((result){
      final userInfoFuture = db.getUsersInfo();
      userInfoFuture.then((result){
        List<UserInfos> userInfosList = List<UserInfos>();
        count = result.length;
        for(int i = 0; i < count; i++){
          userInfosList.add(UserInfos.fromObject(result[i]));
          setState(() {
            userInfos = userInfosList;
            count = count;
            userInfo = UserInfos.fromObject(result[i]);

          });
        }
      });
    });
  }

  //Update user profile name
  var db = new DatabaseHelper();
  void save(String username){
    print("Start save userInfo uid: $_uid and this: ${this._uid}");
    widget.userInfos.uid = this._uid;
    widget.userInfos.userName = username;
    widget.userInfos.dateCreated = DateTime.now().millisecondsSinceEpoch.toString();
    widget.userInfos.logged = 1;
    //db.updateUserInfos(widget.userInfos);
    db.insertUserInfo(widget.userInfos);
    //userInfo.dateCreated = DateTime.now().millisecondsSinceEpoch.toString();
    //userInfo.logged = 1;
    var realTDB = RealtimeCRUDOps(widget.userInfos);
    realTDB.addNewUserActivity();
    goToApp();
  }

  // Firebase sign function
  String _uid = '';
  getUid() {
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this._uid = val.uid;
        print("*****************user ID is:${this._uid} *********and val.uid=:  ${val.uid}");
        return val.uid;
      });
    }).catchError((e) {
      print(e);
    });
  } // actually as UID

  @override
  void initState() {
    super.initState();
    setState(() {
      this.getData();
    });
    getUid();
  }

  static final formKey = new GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  FocusNode _focusNode = new FocusNode();
  void _updateName(String name) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {});
    }
  }

  void _clear() {
    final form = formKey.currentState;
    form.reset();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    var children = [
      _buildInputForm(),
    ];
    if (_name.text.length > 0) {
      var url = 'https://robohash.org/$_name';
      var avatar = new Avatar(url: url, size: 150.0);
      children.addAll([
        new VerticalPadding(child: avatar),
      ]);
    }

    children.addAll([
      new Expanded(child: Container()),
      new Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        new VerticalPadding(
            child: new FlatButton(
              child: new Text(dataTextSpeech['cl'], style: new TextStyle(fontSize: 15.0, color: Colors.blueGrey)),
              onPressed: _clear,
            )),
        new VerticalPadding(
            child: new FlatButton(
              child: Text(dataTextSpeech['getS'],
                  style: new TextStyle(fontSize: 20.0)),
              onPressed: (){save(_name.text);},
            ))
      ])
    ]);

    return new Scaffold(
      appBar: new AppBar(title: Text(dataTextSpeech['R4prof']), automaticallyImplyLeading: false,),
      body: new Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: new Center(
          child: new Column(
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    var children = [
      new VerticalPadding(
          child: new TextFormField(
            controller: _name,
            focusNode: _focusNode,
            decoration: InputDecoration(
                labelText: dataTextSpeech['fillM'],
                hintText: dataTextSpeech['fillG'],
                labelStyle: TextStyle(fontSize: 20.0),
                hintStyle: TextStyle(fontSize: 20.0)
            ),
            style: new TextStyle(fontSize: 24.0, color: Colors.black),
            validator: (val) => val.isEmpty ? dataTextSpeech['notNul'] : null,
          ))
    ];

    return new Form(
      key: formKey,
      child: new Column(
        children: children,
      ),
    );
  }

  Future goToApp() async {
    await Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
          fData.writeDbFile(0, 1);// (walkthrough, login)
          return Walkthrough(widget.userInfos);
    }));
  }
}

class VerticalPadding extends StatelessWidget {
  VerticalPadding({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}