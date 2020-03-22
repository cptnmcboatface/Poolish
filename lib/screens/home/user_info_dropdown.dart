import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poolish/shared/constants.dart';

void settingModalBottomSheet(context, var des,name,add,email) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          
          borderRadius: BorderRadius.circular(15.0),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch
,
              children: <Widget>[
                Container(child: Text("Your Information"),),
                SizedBox(height: 10,),
                ListTile(
                  title: Text("Name",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 10,color: Colors.grey),
                      )),
                  leading: Icon(Icons.person,size: 40,color: mainThemeColor),
                  subtitle: Text(name,style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 17, color: Colors.black),)),
                ),
                SizedBox(height: 10,)
                ,
                ListTile(
                  title: Text("Email",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 10,color: Colors.grey),
                      )),
                  leading: Icon(Icons.email,size: 40,color: mainThemeColor),
                  subtitle: Text(email,style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 17, color: Colors.black),)),
                ),
                SizedBox(height: 10,),
                ListTile(
                  title: Text("You are a",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 10,color: Colors.grey),
                      )),
                  leading:des!="Other"?Icon(Icons.school,size: 40,color: mainThemeColor):Icon(Icons.person_outline,size: 40,color: mainThemeColor),
                  subtitle: Text(des,style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 17, color: Colors.black),)),
                ),
                SizedBox(height: 10,),
                ListTile(
                  title: Text("Adress",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 10,color: Colors.grey),
                      )),
                  leading: Icon(Icons.home,size: 46,color: mainThemeColor,),
                  subtitle: Text(add==null?"N/A":add,style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 17, color: Colors.black),)),
                )

              ],
            ),
          );
        });
  }