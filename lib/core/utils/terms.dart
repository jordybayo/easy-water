import 'package:easywater/core/utils/appText.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  @override
  _TextState createState() => _TextState();
}

class _TextState extends State<TermsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of services"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(dataTextSpeech['termsOfServices']),
          ],
        ),
      ),
    );
  }
}