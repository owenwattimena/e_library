import 'dart:async';

import 'package:flutter/material.dart';

import 'main_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    });
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Image.asset('assets/images/e_library.jpg', width: 150),
            ]),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Flexible(
              child: Text(
                'Selamat datang di E-Library',
                style: TextStyle(fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
