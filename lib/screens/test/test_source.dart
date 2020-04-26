import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poolish/shared/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null) Text(_currentAddress),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.postalCode}, ${place.country},${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }
}
Widget returnWater(BuildContext context){
  return new AlertDialog(
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
      title: Text('Run a New Test',style: GoogleFonts.poppins(textStyle: TextStyle(color: mainThemeColor),)),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('You are logging out. All your data will be saved.',style: GoogleFonts.poppins(textStyle: TextStyle(color: Color.fromRGBO(166, 166, 166, 1)),))
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Yes',style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black))),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('No',style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black))),
        ),
      ],
    );

}