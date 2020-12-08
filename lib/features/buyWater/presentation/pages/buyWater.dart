import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easywater/core/utils/const.dart';
import 'package:easywater/core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:sqflite/sqflite.dart';

class BuyWater extends StatefulWidget {
  /*final UserInfos userInfos;
  BuyWater(this.userInfos);*/
  @override
  _BuyWaterState createState() => new _BuyWaterState();
}

class _BuyWaterState extends State<BuyWater> {
  TextEditingController _c;
  double _metal = 0.0;
  double _total = 0.0;
  String _text = "0";
  double _price = 0.0;
  bool _select1 = true;
  bool _select2 = true;
  bool _select3 = true;
  bool _select4 = true;
  var _db;

  @override
  void initState() {
    _c = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _c?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyles = Theme.of(context).textTheme;
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.appBarBuyWaterFlow,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Constants.primaryColor,
        ),
        body: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: new TextField(
                      scrollPadding: const EdgeInsets.all(20.0),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        filled: true,
                        icon: Icon(Icons.grid_on),
                        hintText: '',
                        labelText: 'flow value',
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                      onChanged: (v) => setState(() {
                        _text = v;
                        _price = double.parse(_text); //
                        _price = _price * 2.5; // 2.5 franc per litter
                      }),
                      controller: _c,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(4),
                        WhitelistingTextInputFormatter.digitsOnly,
                        BlacklistingTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                  Expanded(child: Text("  XAF: $_price")),
                ],
              ),
            ),
            Expanded(
                child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(90),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                SelectableContainer(
                  child: buildTextContentOfContainer('orange_money.jpg'),
                  onPressed: () {
                    setState(() {
                      _select1 = !_select1;
                      _select2 = true;
                      _select3 = true;
                      _select4 = true;
                    });
                  },
                  selected: _select1,
                  padding: 8.0,
                ),
                SelectableContainer(
                  child: buildTextContentOfContainer('mtn_money.jpg'),
                  onPressed: () {
                    setState(() {
                      _select1 = true;
                      _select2 = !_select2;
                      _select3 = true;
                      _select4 = true;
                    });
                  },
                  selected: _select2,
                  padding: 8.0,
                ),
                SelectableContainer(
                  child: buildTextContentOfContainer('eu_money.jpg'),
                  onPressed: () {
                    setState(() {
                      _select1 = true;
                      _select2 = true;
                      _select3 = !_select3;
                      _select4 = true;
                    });
                  },
                  selected: _select3,
                  padding: 8.0,
                ),
                SelectableContainer(
                  child: buildTextContentOfContainer('yup.png'),
                  onPressed: () {
                    setState(() {
                      _select1 = true;
                      _select2 = true;
                      _select3 = true;
                      _select4 = !_select4;
                    });
                  },
                  selected: _select4,
                  padding: 8.0,
                ),
              ],
            )),
            Expanded(
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Purchase"),
                    onPressed: () async {
                      if (_select1 == true &&
                          _select2 == true &&
                          _select3 == true &&
                          _select4 == true) {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            headerAnimationLoop: false,
                            animType: AnimType.TOPSLIDE,
                            title: 'Warning',
                            desc:
                                'you must select at least one mode payment of method',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {})
                          ..show();
                      } else if (_price == 0) {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            headerAnimationLoop: false,
                            animType: AnimType.TOPSLIDE,
                            title: 'Warning',
                            desc: 'you must provide the number of water litter',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {})
                          ..show();
                      } else {


                        AwesomeDialog(
                            context: context,
                            animType: AnimType.LEFTSLIDE,
                            headerAnimationLoop: false,
                            dialogType: DialogType.SUCCES,
                            title: 'Success',
                            desc:
                                'You purchased a pack of $_text litters that coast $_price FCFA',
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                            },
                            btnOkIcon: Icons.check_circle,
                            onDissmissCallback: () {
                              debugPrint('Dialog Dissmiss from callback');
                            })
                          ..show();
                      }
                    },
                    color: Constants.primaryColor,
                  ),
                  RaisedButton(
                    child: Text("Reset"),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Flow value reseted",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                  )
                ],
              ),
            ),
          ],
        )));
  }
}

Widget buildTextContentOfContainer(String company) {
  return Image(image: AssetImage('assets/paymentLogos/$company'));
}
