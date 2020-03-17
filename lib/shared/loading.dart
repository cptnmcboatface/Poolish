import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatelessWidget {
  final String message;
  Loading({this.message});
  @override
  Widget build(BuildContext context) {
    return Material(
          color: Colors.white,
          child: Container(

            decoration: BoxDecoration(
              gradient: LinearGradient(
              colors: [Color.fromRGBO(69, 211, 193,1), Color.fromRGBO(69, 211, 193,0.2)])),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children:[
              
              Text(
                "Poolish",
                style: GoogleFonts.dancingScript(textStyle:TextStyle(fontSize: 100,
                fontFamily: 'DancingScript',
                color: Colors.white)),
              ),
              SizedBox(height: 20,)
              ,
              Text(
                message,
                style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20, color: Colors.white))
              ),
              SizedBox(height: 20,)
              ,
              
              SpinKitChasingDots(
              color : Colors.white,
              size : 40.0,
            )]  
          ),
      
      )
    );
    
  }
}