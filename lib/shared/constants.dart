import 'package:flutter/material.dart';


const textInputDecoration =  InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.yellow)
              ),
              
              suffixStyle: const TextStyle(color: Colors.green));

const textInputStyle = TextStyle(
  fontFamily: 'GlacielIndifference',
);

dynamic mainThemeColor = Color.fromRGBO(69, 211, 193,0.8);
List gradient = <Color>[Color.fromRGBO(69, 211, 193,0.8), Color.fromRGBO(69, 211, 193,0.2)];
dynamic hintStyle = TextStyle(fontFamily: "GlacielIndifference", color: Color.fromRGBO(217, 217, 217, 0.8),);
dynamic labelStyle = TextStyle(fontFamily: "GlacielIndifference", color: Color.fromRGBO(69, 211, 193,0.8));
dynamic errorStyle = TextStyle(fontFamily: "GlacielIndifference", color: Colors.red[100],fontSize: 14);

List<String> testNames = ["Free Chlorine","pH","Total Alkalinity","Hardness","Iron","Copper","Lead","Nitrate","Nitrite","Bromine","Total Chlorine","Chromiuim","Fluoride","Cyanuric Acid"];
