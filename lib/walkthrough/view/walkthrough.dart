import 'package:easywater/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class Walkthrough extends StatefulWidget {
  Walkthrough();
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      PageViewModel(
        title: "Welcome on Easy Water",
        body: "Water is life, We at easy water aim to facilitate access to portable water, while conserving and respecting nature. thanks to new technologies and renewable energy.",
        image: Image.asset(
          "assets/460-4608436_long-term-use-of-ionized-alkaline-water-is.png",
          height: 175.0,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          bodyTextStyle: TextStyle(fontSize: 15.0),
//          dotsDecorator: DotsDecorator(
//            activeColor: Theme.of(context).accentColor,
//            activeSize: Size.fromRadius(8),
//          ),
          pageColor: Theme.of(context).primaryColor,
        ),
      ),

      PageViewModel(
        title:  "Get your water Quick and clean",
        body: "Thanks to the EA system you have continuous access to fresh and potable water.",
        image: Image.asset(
          "assets/wc-broken-waterpump.png",
          height: 185.0,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          bodyTextStyle: TextStyle(fontSize: 15.0),
//          dotsDecorator: DotsDecorator(
//            activeColor: Theme.of(context).accentColor,
//            activeSize: Size.fromRadius(8),
//          ),
          pageColor: Theme.of(context).primaryColor,
        ),
      ),

      PageViewModel(
        title: "EasyPay & EasyShare",
        body: "With EasyWater, buy your water pack directly online, and simply use your phone (NFC) to share or market Water to EasyWater cards",
        image: Image.asset(
          "assets/nfc-checkin-1-1.png",
          height: 175.0,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          bodyTextStyle: TextStyle(fontSize: 15.0),
//          dotsDecorator: DotsDecorator(
//            activeColor: Theme.of(context).accentColor,
//            activeSize: Size.fromRadius(8),
//          ),
          pageColor: Theme.of(context).primaryColor,
        ),
      ),

      PageViewModel(
        title: "Get your water Quick and clean",
        body: "easy water is the fastest and most efficient solution in terms of easy water distribution, we all make an effort to provide you with the best drinking water.",
        image: Image.asset(
          "assets/waterFecth.png",
          height: 175.0,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor,
          ),
          bodyTextStyle: TextStyle(fontSize: 15.0),
//          dotsDecorator: DotsDecorator(
//            activeColor: Theme.of(context).accentColor,
//            activeSize: Size.fromRadius(8),
//          ),
          pageColor: Theme.of(context).primaryColor,
        ),
      ),
    ];

    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: IntroductionScreen(
            pages: pages,
            onDone: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomePage();
                  },
                ),
              );
            },
            onSkip: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return HomePage();
                  },
                ),
              );
            },
            showSkipButton: true,
            skip: Text("Skip"),
            next: Text(
              "Next",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
            done: Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}