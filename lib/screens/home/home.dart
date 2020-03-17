import 'package:flutter/material.dart';
import 'package:poolish/screens/test/test_screen.dart';
import 'package:poolish/shared/constants.dart';
import 'package:poolish/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  final String uid;
  Home({this.uid});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "TestScreen SCREEN",
        home: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: FlatButton(
                  onPressed: () async => await _auth.signOut(),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  shape: new CircleBorder(),
                ),
                title: Text("Pool Tests",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 40, color: Colors.white),
                    )),
                backgroundColor: Colors.white,
                elevation: 0.0,
                flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradient)))),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      color: Color.fromRGBO(217, 217, 217, 1.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        'Complete All Tests to Measure Safety of your Pool',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(166, 166, 166, 1.0),
                                fontSize: 20)),
                        // style: ,
                      )),
                  Expanded(child: Container())
                ])));
    // Container(
    //   child: TestScreen(uid:widget.uid),
    // );
  }
}
