import 'package:easywater/core/utils/appText.dart';
import 'package:flutter/material.dart';

class PolicyPage extends StatefulWidget {
  @override
  _TextState createState() => _TextState();
}

class _TextState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy/Data Policy"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(dataTextSpeech['privacyPolicy']),
          ],
        ),
      ),
    );
  }
}