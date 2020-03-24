import 'package:flutter/material.dart';
import 'package:poolish/shared/login_register_design.dart';
import 'package:poolish/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class UserData extends StatefulWidget {
  final Function updateUserData;
  UserData({this.updateUserData});
  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  String name, add, des;
  var _currentSelectedValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          new Stack(children: [
            CurvedShape(curveHeightCS: CURVE_HEIGHT),
            Container(
                margin: EdgeInsets.only(top: CURVE_HEIGHT - AVATAR_DIAMETER),
                width: double.infinity,
                height: AVATAR_DIAMETER,
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainThemeColor,
                  ),
                  child: new Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: AVATAR_RADIUS,
                  ),
                )),
            Container(
                padding: EdgeInsets.fromLTRB(16, CURVE_HEIGHT, 16, 16),
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      InputDecorator(
                        decoration: textInputDecoration,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text("Are you a...",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Color.fromRGBO(
                                            200, 200, 200, 1.0)))),
                            value: _currentSelectedValue,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _currentSelectedValue = newValue;
                                des = newValue;
                              });
                            },
                            items: designations.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        style: textInputStyle,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter Your Name',
                            labelText: 'Name',
                            hintStyle:
                                GoogleFonts.poppins(textStyle: hintStyle),
                            labelStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1.0))),
                            focusColor: mainThemeColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: mainThemeColor,
                            ))),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a Valid Name' : null,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        style: textInputStyle,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter Address',
                            labelText: 'Address (Optional)',
                            hintStyle:
                                GoogleFonts.poppins(textStyle: hintStyle),
                            labelStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1.0))),
                            focusColor: mainThemeColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: mainThemeColor,
                            ))),
                        onChanged: (val) {
                          add = val;
                        },
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        height: 50.0,
                        child: FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await widget.updateUserData(name, des, add);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(69, 211, 193, 0.8),
                                    Color.fromRGBO(69, 211, 193, 0.2)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text("Next",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            // )
          ])
        ])));
  }
}
