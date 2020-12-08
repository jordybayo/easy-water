
import 'package:easywater/core/utils/appText.dart';
import 'package:easywater/walkthrough/walkthrough.dart';
import 'avatar.dart';
import 'package:flutter/material.dart';

class RegisterThree extends StatefulWidget {

  RegisterThree();

  @override
  State<StatefulWidget> createState() => new _RegisterThreeState();
}

class _RegisterThreeState extends State<RegisterThree> {

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
              onPressed: (){},
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
          return Walkthrough();
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