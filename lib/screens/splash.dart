import 'dart:async';

import 'package:jobtinder/models/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:jobtinder/styles/pallete.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {
  final int splashDuration = 2;

  void checkCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("user-token");

    Timer(Duration(seconds: splashDuration), () async {
      if (token == null) {
        await precacheImage(
          AssetImage("assets/images/login_background.jpg"),
          context,
        );
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        Provider.of<User>(context)..token = token;

        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Pallete.drawerLightGray,
            Pallete.drawerDarkGray,
          ],
          radius: .9,
        ),
      ),
      child: Container(
        height: 30.0,
        width: 30.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Pallete.yellow),
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
