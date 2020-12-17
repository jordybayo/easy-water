import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  User user;
  UserProfile({this.user});

  
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/img/login.png"),
                        radius: 40.0,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.user.name==null ? "User Name": "${widget.user.name}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.user.phoneNumber==null ? "+237-XXX-XXX-XXX": "${widget.user.phoneNumber}",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.user.email==null ? "user@mail.com": "${widget.user.email}",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Easy Water Support",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Address:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                          child: Column(
                            children: <Widget>[
                              Text("+237 693 448 946"),
                              Text("+237 656 714 050"),
                              Text("infos@easywater.com"),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Country:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                          child: Text("Cameroon, CM"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


