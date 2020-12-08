import 'package:easywater/core/utils/appText.dart';
import 'register3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class PinCodeVerificationScreen extends StatefulWidget {

  final String phoneNumber;
  final String verificationId;
  PinCodeVerificationScreen(this.phoneNumber,this.verificationId);


  @override
  _PinCodeVerificationScreenState createState() => _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;
  bool hasError = false;
  String smsCode = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FlareActor(
                  "assets/animations/otp.flr",
                  animation: "otp",
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(dataTextSpeech['phoneNumberVerif'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: dataTextSpeech['spaceToEnterCode'],
                      children: [
                        TextSpan(
                          text: widget.phoneNumber,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    length: 6,
                    obsecureText: false,
                    animationType: AnimationType.fade,
                    shape: PinCodeFieldShape.underline,
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    backgroundColor: Colors.white,
                    fieldWidth: 40,
                    onChanged: (value){
                      setState(() {
                        smsCode = value;
                      });
                    },
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(color: Colors.red.shade300, fontSize: 15),
                ),
              ),
              SizedBox(height: 20,),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: dataTextSpeech['askIfReceiveCode'],
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    children: [
                      TextSpan(
                        text: dataTextSpeech['resendCode'],
                        recognizer: onTapRecognizer,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ]
                ),
              ),
              SizedBox(height: 14,),
              Container(
                margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: FlatButton(
                    onPressed: () {
                      // conditions for validating
                      /*FirebaseAuth.instance.currentUser().then((user) {
                        if (user != null) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
                              RegisterThree()
                          ));
                        } else {
                          signIn();
                        }
                      });*/

                    },
                    child: Center(
                        child: Text(
                          dataTextSpeech['verify'].toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.deepOrange.shade200,
                          offset: Offset(1, -2),
                          blurRadius: 5
                      ),
                      BoxShadow(
                          color: Colors.deepOrange.shade200,
                          offset: Offset(-1, 2),
                          blurRadius: 5
                      )
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signIn()async{
    final AuthCredential credential= PhoneAuthProvider.getCredential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
          RegisterThree()
      ));
    }).catchError((e)=>print(e));
  }

}

