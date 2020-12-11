import 'package:easywater/data/user_repository.dart';
import 'package:easywater/home/home_page.dart';
import 'package:easywater/login/login_page.dart';
import 'package:easywater/splash/splash_page.dart';
import 'package:easywater/userdetail/edit_user_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const String LOGIN_PAGE = "/login";
const String SPLASH_PAGE = "/";
const String HOME_PAGE = "/home";
const String USER_DETAIL = "/user_detail";

class Router {
  static final userRepository =
      UserRepository(firebaseAuth: FirebaseAuth.instance);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                LoginPage(userRepository: userRepository));
      case HOME_PAGE:
        return MaterialPageRoute(builder: (_) => HomePage());
      case SPLASH_PAGE:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case SPLASH_PAGE:
        return MaterialPageRoute(builder: (_) => EditUserDetail());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
