import 'package:authentication_repository/authentication_repository.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easywater/authentication/authentication.dart';
import 'package:easywater/core/utils/const.dart';
import 'package:easywater/core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wave_progress_widget/wave_progress.dart';
import 'package:datastore_repository/datastore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WriteFlowToNFCTag extends StatefulWidget {
  User user;
  WriteFlowToNFCTag({this.user});
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WriteFlowToNFCTag());
  }

  @override
  _WriteFlowToNFCTagState createState() => _WriteFlowToNFCTagState();
}

class _WriteFlowToNFCTagState extends State<WriteFlowToNFCTag> {
  double _progress = 50.0;
  TextEditingController writerController;
  static double _cardValue = 0;
  String _cardId;
  CollectionReference cardTags = FirebaseFirestore.instance.collection('card_tags');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    writerController = TextEditingController();
    writerController.text = '';
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      print(onData.id);
      this._cardId  = onData.id;
      print(onData.content);

      /*Fluttertoast.showToast(
          msg: "Current Litter: ${onData.content}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 20.0
      );*/
      AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: DialogType.NO_HEADER,
        title: 'Litters',
        desc:
            'The current value of flow water of your tag is ${onData.content}',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.credit_card,
      )..show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.appBarChargeTag,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Constants.primaryColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WaveProgress(180.0, Colors.blue, Colors.blueAccent, _progress),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Slider(
                    max: 100.0,
                    min: 0.0,
                    value: _progress,
                    onChanged: (value) {
                      setState(() => _progress = value);
                    }),
              ),
              Text(
                '${_progress.round()}',
                style: TextStyle(color: Colors.blueAccent, fontSize: 40.0),
              ),
              Padding(
                padding: const EdgeInsets.all(70.0),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Transfer Flow"),
                    onPressed: () {
                      FlutterNfcReader.write("$_progress", writerController.text)
                          .then((value) async {
                        //TODO : implement updating water flow and logs hhistory
                        await cardTags
                            .doc(this._cardId)
                            .get()
                            .then<dynamic>((DocumentSnapshot snapshot) async {
                          var data = snapshot.data();
                          if (data != null) {

                            List<dynamic> history = data['history']; // get online history data to add new history and save again
                            double waterpackFlow = _progress;
                            history.add({'purchased': '${DateTime.now()},$waterpackFlow'});

                            await DatastoreRepository().updateNfcTagWaterFlow(documentId: this._cardId, newFlow:  _progress);

                            await DatastoreRepository().logHistoryNfcTagWaterFlow(documentId: this._cardId, newHistory: history);
                          } else {
                            DatastoreRepository().addNfcTag(id: this._cardId);
                            DatastoreRepository().updateNfcTagWaterFlow(documentId: this._cardId, newFlow: _progress);
                          }
                        });
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            headerAnimationLoop: false,
                            animType: AnimType.TOPSLIDE,
                            title: 'Transfer successfully completed',
                            desc: 'You Transfered $_progress L  water Flow to the card. Thank you for using our service',
                            btnOkOnPress: () {})
                          ..show();
                      });
                    },
                    color: Constants.primaryColor,
                  ),
                  /*RaisedButton(
                    child: Text("Read Tag"),
                    onPressed: ()  async => await FlutterNfcReader.read().then((value) {
                      AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.NO_HEADER,
                        title: 'Litters',
                        desc:
                        'The current value of flow water of your tag is ${value.content}',
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                        },
                        btnOkIcon: Icons.credit_card,
                      )..show();
                    }),
                  ),*/
                ],
              ),
            ],
          ),
        ));
  }
}
