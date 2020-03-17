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
            body: Container(
              // margin: EdgeInsets.symmetric(vertical:20),
              // padding: EdgeInsets.symmetric(vertical:20),
              alignment: Alignment.center,
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: homeScreenCards(),
              ),
            )));
    // Container(
    //   child: TestScreen(uid:widget.uid),
    // );
  }

  List<Widget> homeScreenCards() {
    List<Widget> jobCategoriesCards = [];

    List<Widget> rows = [];
    var jobCategories = [
      {"name":"Run Test",
        // "image" : 
      },
      {"name":"Previous Results"},
      {"name":"Your Information"},
      {"name":"Settings"}
    ];
    int i = 0;
    for (var category in jobCategories) {
      if (i < 2) {
        rows.add(getCategoryContainer(category["name"]));
        i++;
      } else {
        i = 0;
        jobCategoriesCards.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ));
        rows = [];
        rows.add(getCategoryContainer(category["name"]));
        i++;
      }
    }
    if (rows.length > 0) {
      jobCategoriesCards.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows,
      ));
    }
    return jobCategoriesCards;
  }

  Widget getCategoryContainer(String categoryName) {
    return new Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: 20),
        height: 160,
        width: 140,
        //
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: FlatButton(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon
                (Icons.info,size: 60,
                  color: mainThemeColor,
                ),
                SizedBox(height: 10,)
                ,
                Text(categoryName),
                
              ],
            ),
          ),
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            
          ),
          
        ));
  }
}
