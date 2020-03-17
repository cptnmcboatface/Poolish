import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poolish/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:poolish/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => StreamProvider.value(
                value: AuthService().user,
                child: MaterialApp(home: Wrapper())))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(69, 211, 193, 1),
                Color.fromRGBO(69, 211, 193, 0.2)
              ])),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Poolish",
                      style: GoogleFonts.dancingScript(
                          textStyle:
                              TextStyle(fontSize: 100, color: Colors.white)),
                    ),
                    SizedBox(height: 20),
                    SpinKitChasingDots(
                      color: Colors.white,
                      size: 50.0,
                    )
                  ]),
            )));
  }
}
