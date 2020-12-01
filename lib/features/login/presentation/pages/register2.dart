import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:easywater/core/services/databaseHelperUserInfo.dart';
import 'package:easywater/core/utils/appText.dart';
import 'package:easywater/core/models/userInfo.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:flutter/services.dart'
    show
    BlacklistingTextInputFormatter,
    LengthLimitingTextInputFormatter,
    TextInputFormatter,
    WhitelistingTextInputFormatter,
    rootBundle;
import 'codeVerification.dart';
import 'selectCountry.dart';
import 'selectLanguage.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterTwo extends StatefulWidget {
  @override
  _RegisterTwoState createState() => _RegisterTwoState();
}

class _RegisterTwoState extends State<RegisterTwo> {

  _RegisterTwoState() {
    this.register2Speech();
    this.getData();
    this.userInfo = new UserInfos("", "", "", "", "", "", "", "", "", 0, 0.0);
    this.userInfo.darkTheme = 1;
  }

  TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<UserInfos> userInfos;
  UserInfos userInfo;
  int count = 0;

  DatabaseHelper db = new DatabaseHelper();

  void _handleSubmitted(String uid, String uName, String dialcode, String pNumber, String verificationCode, String verificationID, String country, String langD, int logged) async{
    //await db.dropTableUserInfo();
    setState(() {
      userInfo = new UserInfos(uid, uName, "", dialcode, pNumber, verificationCode, verificationID, langD, country, 0, 0.0); // set logged to zero initially
      userInfo.darkTheme = 1;
    });
  }

  void getData(){
    final dbFuture = db.initializeDb();
    //Si la bd est chargé
    dbFuture.then((result){
      final userInfoFuture = db.getUsersInfo();
      userInfoFuture.then((result){
        List<UserInfos> userInfosList = List<UserInfos>();
        count = result.length;
        for(int i = 0; i < count; i++){
          userInfosList.add(UserInfos.fromObject(result[i]));
          print(result[i].toString()+"^^^");
          setState(() {
            userInfos = userInfosList;
            count = count;
            userInfo = UserInfos.fromObject(result[i]);
          });
        }
      });
    });
  }

  void save(String phoneNumber){
    userInfo.phoneNumber = phoneNumber;
    db.updateUserInfos(userInfo);
  }

  Future<void> register2Speech() async {
    bool response = await db.check();
    debugPrint(response.toString());
    if(response){
      this._handleSubmitted("", "", "", "", "", "", "", "", 0); //create the sqflite database for user info
    }
  }

  void saveAuthPhoneInfo(String verificationCode, String verificationID){
    print(verificationID);
    print(verificationCode);
    userInfo.verificationCode = verificationCode;
    userInfo.verificationID = verificationID;
    db.updateUserInfos(userInfo);
  }

  //part2
  static final TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
  );
  TextEditingController _pinEditingController = TextEditingController();
  PinDecoration _pinDecoration = UnderlineDecoration(
    textStyle: _textStyle,
    enteredColor: Colors.deepOrange,
  );

  static var _phoneNumber;
  static var _dialCode;
  void getUserPhoneDetails(){
    _phoneNumber = userInfo.phoneNumber;
    _dialCode = userInfo.dialCode;
    phoneNo = _dialCode.toString() + _phoneNumber.toString();
  }
  //sms verification function
  String phoneNo;
  String smsCode;
  String verificationId;
  bool isCome = false;

  Future<void> verifyNumber() async{
    print("phoneNo is $phoneNo");
    final PhoneCodeAutoRetrievalTimeout autoRetrieve=(String verID){
      this.verificationId=verID;
    };

    final PhoneVerificationCompleted verificationSuccess=(AuthCredential credential){
      print("Verified");
      setState(() {
        isCome = true;
      });
    };

    final PhoneCodeSent smsCodeSent=(String verID,[int forceCodeResend]){
      this.verificationId=verID;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => PinCodeVerificationScreen(this.phoneNo,userInfo,this.verificationId)),
      );
    };

    final PhoneVerificationFailed verificationFailed=(AuthException exception){
      print('$exception.message error in verifying');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationSuccess,
        verificationFailed: verificationFailed
    );

  }

  @override
  void initState() {
    super.initState();
  }

  //UI page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    if(userInfos == null){
      userInfos = List<UserInfos>();
      getData();
    }
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: Text(
                  dataTextSpeech['verifyTitle'],
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
                child: RichText(
                  text: new TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal),
                    children: <TextSpan>[
                      new TextSpan(text: dataTextSpeech['infoMsg']),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),

              Column(
                children: <Widget>[
                  FlatButton(
                    child: Text(//_dataTextSpeech['lang'],
                      (userInfo.displayLanguage == null || userInfo.displayLanguage == "")  ? dataTextSpeech['lang']: userInfo.displayLanguage,
                      style: TextStyle(color: Colors.grey.shade700),),
                    onPressed: () => goToSelectLanguage(userInfo),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Text(
                        (userInfo.dialCode == null || userInfo.dialCode == "") ? dataTextSpeech['country'] : userInfo.dialCode,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      onPressed: () => _openCountryPickerDialog(context),//goToSelectCountry(userInfo),
                    ),
                  ),
                  Expanded(
                      child: TextField(
                        scrollPadding: const EdgeInsets.all(20.0),
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          filled: true,
                          icon: Icon(Icons.phone),
                          hintText: '',
                          labelText: 'phone number',
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (String value) {save(value);},
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(16),
                          WhitelistingTextInputFormatter.digitsOnly,
                          BlacklistingTextInputFormatter.singleLineFormatter,
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 150,
              ),

              //Next
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: (){
                        if(verifyValue()){
                          getUserPhoneDetails();
                          verifyNumber();
                          if(!isCome){
                            showModal(context);
                          }
                        }
                      },
                      color: Colors.blue.shade400,
                      child: Text(
                        dataTextSpeech['next'],
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future goToSelectCountry(UserInfos userInfos) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return SelectCountry(userInfos);
        }));
  }

  showModal(BuildContext context){
    return showDialog(
        context:context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: new Container(
              height: 80.0,
              child: new Column(
                children: <Widget>[
                  new CircularProgressIndicator(
                    backgroundColor: Colors.deepOrange,
                  ),
                  SizedBox(height: 8.0,),
                  Text('Sending code ...')
                ],
              ),
            ),
          );
        }
    );
  }

  bool verifyValue(){
    if(userInfo.dialCode.isEmpty || phoneNumberController.text.isEmpty || userInfo.displayLanguage.isEmpty){
      scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("All fields is required"),
          )
      );
      return false;
    }else{
      return true;
    }
  }
  void _openCountryPickerDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Phone code'),
            onValuePicked: (Country country) =>
                setState(() => userInfo.dialCode = "+"+country.phoneCode),
            itemBuilder: _buildDialogItem)),
  );

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 8.0),
      Text("+${country.phoneCode}"),
      SizedBox(width: 8.0),
      Flexible(child: Text(country.name))
    ],
  );

  Future goToSelectLanguage(UserInfos userInfos) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return SelectLanguage(userInfos);
        }));
  }

}