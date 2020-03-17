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
Map<String,List<String>> colorCodes={
  "pH":"EB596A ED636A ED7B67 ECA16E D5B663 ACB460 8FA460".split(" "),
  "Free Chlorine": "F9F9FA E5E9EC C2E1E8 8BCAD5 3D9BC7 1C7FBD 1A70B9".split(" "),
  "Total Alkalinity":"EAB660 E0B265 CFA86A 5D746C 2C5472 223F81 2A3887".split(" "),
  "Hardness":"3D83C5 426EB6 534F9A 71438D 84438C 883E8".split(" "),
  "Iron":"F9F9FA E9DBD6 EDC1BA EBA796 EA7A6B E45D5A E95350 DF4646".split(" "),
  "Copper":"A29181 B19182 A37C75 917571 565768 233254".split(" "),
  "Chromiuim":"eaa7cc d272ad bf4a89 9f2774 902064 851c58".split(" "),
  "Fluoride" : "d6413f d53f46 d95452 dd6d47 d98944".split(" "),
  "Cyanuric Acid": "c31f3d c3203c ce2035 d13a39 d25a30".split(" "),
  "Total Chlorine":"F9F9FA e59ac0 e04b8b e13a7a c5236a 77194".split(" "),
  "Nitrate":"F9F9FA F9F9F2 EDD2E3 E79DC5 D8539B AD3376 AF3167".split(" "),
  "Nitrite":"F9F9FA F6E7F1 EBD2E6 E4A3C9 E264A5 dc4c8b af3772".split(" "),
  "Bromine":"F9F9FA a6d1de 58abda 296bb5 0c4d9c".split(" "),
  "Lead":"F4AA62 F4944D EE7767 E0595E CE3E67 B1255".split(" ")
  };

enum HomeScreenID { 
   test, 
   previousResults, 
   yourInfo, 
   setting,
   logOut, 
}
