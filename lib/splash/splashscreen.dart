import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        //margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Padding(
          padding: const EdgeInsets.all(175.0),
          child: FlareActor("assets/animations/easy_water.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
              animation: 'Untitled'),
        )
      ),
    );
  }
}
