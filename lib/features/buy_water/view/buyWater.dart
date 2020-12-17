import 'package:authentication_repository/authentication_repository.dart';
import 'package:datastore_repository/datastore_repository.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easywater/core/utils/const.dart';
import 'package:easywater/core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyWater extends StatefulWidget {
  User user;
  BuyWater({this.user});
  @override
  _BuyWaterState createState() => new _BuyWaterState();
}

class _BuyWaterState extends State<BuyWater> {
  TextEditingController _c;
  double _metal = 0.0;
  double _total = 0.0;
  String _text = "0";
  double _price = 0.0;
  bool _select1 = false;
  bool _select2 = false;
  bool _select3 = false;
  bool _select4 = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    _c = new TextEditingController();
    super.initState();
    print("#######voici le id du user ${widget.user.id}");
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
                      _select2 = false;
                      _select3 = false;
                      _select4 = false;
                    });
                  },
                  selected: _select1,
                  padding: 8.0,
                ),
                SelectableContainer(
                  child: buildTextContentOfContainer('mtn_money.jpg'),
                  onPressed: () {
                    setState(() {
                      _select1 = false;
                      _select2 = !_select2;
                      _select3 = false;
                      _select4 = false;
                    });
                  },
                  selected: _select2,
                  padding: 8.0,
                ),
                SelectableContainer(
                  child: buildTextContentOfContainer('eu_money.jpg'),
                  onPressed: () {
                    setState(() {
                      _select1 = false;
                      _select2 = false;
                      _select3 = !_select3;
                      _select4 = false;
                    });
                  },
                  selected: _select3,
                  padding: 8.0,
                ),
                SelectableContainer(
                  child: buildTextContentOfContainer('yup.png'),
                  onPressed: () {
                    setState(() {
                      _select1 = false;
                      _select2 = false;
                      _select3 = false;
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
                      if (_select1 == false &&
                          _select2 == false &&
                          _select3 == false &&
                          _select4 == false) {
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
                        //TODO : implement updating water flow and logs hhistory
                        await users
                            .doc(widget.user.id)
                            .get()
                            .then<dynamic>((DocumentSnapshot snapshot) async {
                              var data = snapshot.data();
                              if (data != null) {

                                List<dynamic> history = data['history']; // get online history data to add new history and save again
                                double waterpackFlow = double.parse(_c.text) + data["water_flow"];
                                history.add({'purchased': '${DateTime.now()},$waterpackFlow'});

                                await DatastoreRepository().updateUserWaterFlow(
                                    documentId: widget.user.id,
                                    newFlow: waterpackFlow);

                                await DatastoreRepository().logHistoryUserWaterFlow(documentId: widget.user.id, newHistory: history);
                              } else {
                                await DatastoreRepository().addUser(
                                    id: widget.user.id,
                                    name: widget.user.name,
                                    phoneNumber: widget.user.phoneNumber,
                                    waterFlow: 0,
                                    email: widget.user.email);
                                await DatastoreRepository().updateUserWaterFlow(
                                    documentId: widget.user.id,
                                    newFlow: double.parse(_c.text));
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    headerAnimationLoop: false,
                                    animType: AnimType.TOPSLIDE,
                                    title: 'Purchase successfully completed',
                                    desc: 'You bought ${_c.text}L  water Flow. Thank you for using our service',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {})
                                  ..show();
                              }
                        });
                      }
                    },
                    color: Constants.primaryColor,
                  ),
                  RaisedButton(
                    child: Text("Reset"),
                    onPressed: () {
                      _c.clear();
                      _text = "0";
                      _price = 0;
                      setState(() {
                        Fluttertoast.showToast(
                            msg: "Flow value reseted",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueGrey,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
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
