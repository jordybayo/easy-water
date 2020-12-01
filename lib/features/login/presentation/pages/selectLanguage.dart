import 'package:easywater/core/services/databaseHelperUserInfo.dart';
import 'package:easywater/core/utils/appText.dart';
import 'package:easywater/core/utils/languagesCodes.dart';
import 'package:easywater/core/models/userInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'register2.dart';


class SelectLanguage extends StatefulWidget {
  final UserInfos userInfos;
  SelectLanguage(this.userInfos);

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  List<Map<String, dynamic>> _dataCodes2 = List<Map<String, dynamic>>();

  _SelectLanguageState() {
    _dataCodes2 = langs;
  }

  TextEditingController editingController = TextEditingController();
  List<Map<String, dynamic>> _dataCodes = langs;
  var db = new DatabaseHelper();


  void save(String lang){
    widget.userInfos.displayLanguage = lang;
    db.updateUserInfos(widget.userInfos);
    debugPrint("langue change~~~"+widget.userInfos.displayLanguage.toString());
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text(dataTextSpeech['appBarLang']),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  var text = value.toLowerCase();
                  setState(() {
                    if(text == "") {
                      _dataCodes = _dataCodes2;
                    }
                    _dataCodes = _dataCodes2.where((lang) {
                      String name = lang["name"];
                      name = name.toLowerCase();
                      return name.contains(text);
                    }).toList();
                  });
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    focusColor: Colors.deepOrange,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))
                ),
              ),
            ),
            Expanded(
              child: new Center(
//        child: new Text('hello world ${dataCodes[1]['name']}'),
                child: new ListView.builder(
                  itemCount: _dataCodes.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (BuildContext context, int position){
                    if(position.isOdd) return new Divider();
                    return new ListTile(
                      title: new Text("${_dataCodes[position]['nativeName']}  -   ${_dataCodes[position]['name']}",style: TextStyle(fontSize: 15.9),),
                      leading: new CircleAvatar(
                        backgroundColor: Colors.white,
                        child: new Text("  ${_dataCodes[position]['code']}",style: TextStyle(fontSize: 18.9),),
                      ),
                      onTap: () async{
                        save( _dataCodes[position]['name']);
                        //int boolUpdateLangDisplay = await db.updateCell('displaylanguage', _dataCodes[position]['name'].toString(), 1);
                        //print("bool update display language {$_dataCodes[position}");
                        //goToRegisterTwo();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        )
    );
  }

  Future goToRegisterTwo() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return RegisterTwo();
        }));
  }
}
