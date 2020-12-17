
import 'package:easywater/features/buy_water/buy_water.dart';
import 'package:easywater/features/nfc_tags/view/write_flow_to_nfc.dart';
import 'package:easywater/features/user_settings/user_settings.dart';
import 'package:easywater/home/widgets/textstyle.dart';
import 'package:easywater/walkthrough/walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easywater/authentication/authentication.dart';
import 'package:easywater/authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'assets/img/umbrella.png',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text(
              "Douala",
              style: cityStyle(),
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            child: new Image.asset("assets/img/light_rain.png"),
          ),
          //Container of temparature
          new Container(
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    "15 C",
                    style: new TextStyle(
                        fontSize: 45.9,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: new ListTile(
                    title: new Text(
                      "Humidity: 140 \n"
                      "Min: 100 C\n"
                      "Max: 200 C",
                      style: extraData(),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(80),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text("buy Water"),
                    color: Colors.deepOrange,
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return BuyWater(user: user,);
                  })),
                ),
                SizedBox(
                  height: 150,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text("tags"),
                    color: Colors.blue,
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return WriteFlowToNFCTag(user: user);
                  })),
                ),
                SizedBox(
                  height: 150,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text("easy water"),
                    color: Colors.yellow,
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return Walkthrough();
                      })),
                ),
                SizedBox(
                  height: 150,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text("settings"),
                    color: Colors.green,
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return UserProfile(user: user,);
                      })),
                ),
              ],
            ),
          ),
        ],
      ),
      /*body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Avatar(photo: user.photo),
            const SizedBox(height: 4.0),
            Text(user.email, style: textTheme.headline6),
            const SizedBox(height: 4.0),
            Text(user.name ?? '', style: textTheme.headline5),
          ],
        ),
      ),*/
    );
  }
}
