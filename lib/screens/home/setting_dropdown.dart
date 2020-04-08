import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poolish/shared/constants.dart';

class SettingsModelBottomSheetWidget extends StatefulWidget {
  final String name, des, add, email;
  final Function updateUserDataDocument;
  SettingsModelBottomSheetWidget({this.name, this.des, this.add, this.email, this.updateUserDataDocument});
  @override
  _SettingsModelBottomSheetWidgetState createState() =>
      _SettingsModelBottomSheetWidgetState();
}

class _SettingsModelBottomSheetWidgetState
    extends State<SettingsModelBottomSheetWidget> {
  String _currName, _currDes, _currAdd, _currEmail, des;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _currName = _currName == null ? widget.name : _currName;
    _currDes = _currDes == null ? widget.des : _currDes;
    _currAdd = _currAdd == null ? widget.add : _currAdd;
    _currEmail = widget.email;
    return Container(
      padding:MediaQuery.of(context).viewInsets,
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Change your information.",
              style: GoogleFonts.poppins(),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            initialValue: _currName,
            autofocus: false,
            decoration: textInputDecoration.copyWith(
                hintText: "Enter Your Name",
                labelText: 'Name',
                hintStyle: GoogleFonts.poppins(textStyle: hintStyle),
                labelStyle: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0))),
                focusColor: mainThemeColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: mainThemeColor,
                ))),
            onChanged: (val) => setState(() => _currName = val),
            validator: (val)=> val.isEmpty ?"Enter Name":null,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: _currAdd,
            autofocus: false,
            decoration: textInputDecoration.copyWith(
                hintText: "Enter Your Address",
                labelText: 'Address',
                hintStyle: GoogleFonts.poppins(textStyle: hintStyle),
                labelStyle: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(color: Color.fromRGBO(200, 200, 200, 1.0))),
                focusColor: mainThemeColor,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: mainThemeColor,
                ))),
            onChanged: (val) => setState(() => _currAdd = val),
          ),
          SizedBox(height: 20.0),
          InputDecorator(
            decoration: textInputDecoration,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Are you a...",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1.0)))),
                value: _currDes,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    _currDes = newValue;
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
          SizedBox(height: 20.0),
          Container(
            height: 50.0,
            child: FlatButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  
                  widget.updateUserDataDocument(_currName,_currDes,_currAdd);
                  setState(() {
                    _currAdd = null;
                    _currDes = null;
                    _currName = null;
                  });
                  
                  Navigator.pop(context);

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
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Update",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

void settingModalBottomSheet(context, var des, name, add, email, Function updateUserDataDocument) {

  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      builder: (BuildContext context) {
        return Wrap(

          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SettingsModelBottomSheetWidget(
                name: name,
                des: des,
                add: add,
                email: email,
                updateUserDataDocument: updateUserDataDocument,
              ),
            ),
          ],
        );
      });
}
