class UserInfos {
  int _id;
  String _uid;
  String _userName;
  String _dateCreated;
  String _dialCode;
  String _phoneNumber;
  String _verificationCode;
  String _verificationID;
  String _displayLanguage;
  String _country;
  int _logged;
  int _darkTheme;
  double _waterFlow;

  UserInfos(this._uid, this._userName, this._dateCreated, this._dialCode, this._phoneNumber,
      this._verificationCode, this._verificationID,this._displayLanguage, this._country, this._logged, this._waterFlow);


  UserInfos.withId(this._id, this._uid, this._userName, this._dateCreated, this._dialCode,
      this._phoneNumber, this._verificationCode, this._verificationID, this._displayLanguage, this._country, this._logged, this._waterFlow);

  UserInfos.map(dynamic obj){
    this._id = obj["id"];
    this._uid = obj["uid"];
    this._userName = obj["userName"];
    this._dateCreated = obj["dateCreated"];
    this._dialCode = obj["dialCode"];
    this._phoneNumber = obj["phoneNumber"];
    this._verificationCode = obj["verificationCode"];
    this._verificationID = obj["verificationID"];
    this._country = obj["country"];
    this._displayLanguage = obj["displanguage"];
    this._logged = obj["logged"];
    this._darkTheme = obj["darkTheme"];
    this._waterFlow = obj["waterFlow"];
  }

  UserInfos.fromObject(dynamic map){
    this._id = map["id"];
    this._uid = map["uid"];
    this._userName = map["userName"];
    this._dateCreated = map["dateCreated"];
    this._dialCode = map["dialCode"];
    this._phoneNumber = map["phoneNumber"];
    this._verificationCode = map["verificationCode"];
    this._verificationID = map["verificationID"];
    this._country = map["country"];
    this._displayLanguage = map["displanguage"];
    this._logged = map["logged"];
    this._darkTheme = map["darkTheme"];
    this._waterFlow = map["waterFlow"];
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["uid"] = _uid;
    map["userName"] = _userName;
    map["dateCreated"] = _dateCreated;
    map["dialCode"] = _dialCode;
    map["phoneNumber"] = _phoneNumber;
    map["verificationCode"] = _verificationCode;
    map["verificationID"] = _verificationID;
    map["country"] = _country;
    map["displayLanguage"] = _displayLanguage;
    map["logged"] = _logged;
    map["darkTheme"] = _darkTheme;
    map["water_flow"] = _waterFlow;
    if(_id!=null){
      map["id"] = _id;
    }
    return map;
  } // or toJson can work too by returning return {"water_flow":0, "uname":""}



  String get uid => this._uid;
  String get userName => this._userName;
  String get dialCode => this._dialCode;
  String get phoneNumber => this._phoneNumber;
  String get verificationCode => this._verificationCode;
  String get verificationID => this._verificationID;
  String get displayLanguage => this._displayLanguage;
  String get country => this._country;
  String get dateCreate => this._dateCreated;
  int get logged => this._logged;
  int get darkTheme => this._darkTheme;
  int get id => this._id;
  double get waterFlow => this._waterFlow;



  set country(String value) {
    _country = value;
  }

  set displayLanguage(String value) {
    _displayLanguage = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  set verificationCode(String value) {
    _verificationCode = value;
  }

  set verificationID(String value) {
    _verificationID = value;
  }

  set dialCode(String value) {
    _dialCode = value;
  }

  set dateCreated(String value) {
    _dateCreated = value;
  }

  set userName(String value) {
    _userName = value;
  }

  set logged(int value) {
    _logged = value;
  }

  set darkTheme(int value) {
    _darkTheme = value;
  }

  set waterFlow(double value) {
    _waterFlow = waterFlow;
  }

  set uid(String value){
    _uid = value;
  }

  set id(int value) {
    _id = value;
  }
}