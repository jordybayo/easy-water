import '../../data/dataPolicy.dart';
import '../../data/terms.dart';
import 'register2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:easywater/core/utils/appText.dart';


class RegisterOne extends StatefulWidget {
  @override
  _RegisterOneState createState() => _RegisterOneState();
}

class _RegisterOneState extends State<RegisterOne> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              new Center(
                child: Text(
                  dataTextSpeech['welcome'],
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w200),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                width: 250,
                child: Image.asset('assets/img/logo.png'),
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                child: RichText(
                  text: new TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 11.0, fontWeight: FontWeight.w200, fontStyle: FontStyle.italic),
                    children: <TextSpan>[
                      new TextSpan(text: dataTextSpeech['read']),
                      new TextSpan(
                        text: dataTextSpeech['privacy'],
                        style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,),
                        recognizer: new TapGestureRecognizer()..onTap = () => goToPrivacyPolicyScreen(),
                      ),
                      new TextSpan(text: dataTextSpeech['tapAgreeMsg']),
                      new TextSpan(
                        text: dataTextSpeech['terms'],
                        style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,),
                        recognizer: new TapGestureRecognizer()..onTap = () => goToTermsOfServicesScreen(),
                      ),
                      new TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => goToRegisterTwo(),
                      color: Colors.blue.shade400,
                      child: Text(
                        dataTextSpeech["buttonAgree"],
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future goToRegisterTwo() async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return RegisterTwo();
        }));
  }

  goToPrivacyPolicyScreen() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return PolicyPage();
        }));
  }

  goToTermsOfServicesScreen() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return TermsPage();
        }));
  }
}