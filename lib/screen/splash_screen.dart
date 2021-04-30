import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
      Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 50, 20, 10),
              child:Image.asset('assets/images/logo2.png',
              scale: 0.4,)
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 15),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                ],
              ), 
            ),
            Text("Loading"),
          ],)
      ),
    );
  }
}