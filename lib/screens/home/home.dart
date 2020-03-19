import 'package:flutter/material.dart';
import 'package:poolish/screens/authenticate/user_data_collection.dart';
import 'package:poolish/shared/constants.dart';
import 'package:poolish/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poolish/screens/test/test_screen.dart';
import 'package:poolish/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poolish/shared/loading.dart';

class Home extends StatefulWidget {
  @override
  final String uid;
  var dB;
  Home({this.uid}) {
    dB = DatabaseService(uid: uid);
  }

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  var add,name,des,email;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: widget.dB.userDataStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading(message: "",);
        } else if (snapshot.data.data == null || snapshot.data.data['name']=="") {
          return UserData(updateUserData:widget.dB.updateUserDataDocument);
        } else {
          DocumentSnapshot docs = snapshot.data;
          var testResults = docs.data;
          name=testResults["name"];
          email=testResults["email"];
          des=testResults["designation"];
          add=testResults["address"];
          return homeScreen();
        }

        // return listsWidget(testResults);
      },
    );
  }

  Widget homeScreen() {
    return MaterialApp(
        title: "TestScreen SCREEN",
        home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  flexibleSpace: Container(
                      alignment: Alignment.center,
                      child: Text("Poolish",
                          style: GoogleFonts.dancingScript(
                            textStyle:
                                TextStyle(fontSize: 80, color: Colors.white),
                          )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50)),
                          gradient: LinearGradient(colors: gradient)))),
            ),
            body: Container(
              alignment: Alignment.center,
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: homeScreenCards(),
              ),
            )));
  }

  List<Widget> homeScreenCards() {
    List<Widget> jobCategoriesCards = [];

    List<Widget> rows = [];
    var jobCategories = [
      {
        "name": "Run Water Test",
        "icon": Icons.playlist_add_check,
        "id": HomeScreenID.test
      },
      {
        "name": "Previous Results",
        "icon": Icons.history,
        "id": HomeScreenID.previousResults
      },
      {
        "name": "Your Information",
        "icon": Icons.info_outline,
        "id": HomeScreenID.yourInfo
      },
      {
        "name": "Change Settings",
        "icon": Icons.settings,
        "id": HomeScreenID.setting
      },
      {
        "name": "Log Out",
        "icon": Icons.person_outline,
        "id": HomeScreenID.logOut
      }
    ];
    int i = 0;
    for (var category in jobCategories) {
      if (i < 2) {
        rows.add(getCategoryContainer(category));
        i++;
      } else {
        i = 0;
        jobCategoriesCards.add(new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rows,
        ));
        rows = [];
        rows.add(getCategoryContainer(category));
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

  Widget getCategoryContainer(var categoryName) {
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
              color: Colors.grey[350],
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
                Icon(
                  categoryName["icon"],
                  size: 60,
                  color: mainThemeColor,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(categoryName["name"],
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )),
              ],
            ),
          ),
          onPressed: () {
            changeScreen(categoryName["id"]);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ));
  }

  void changeScreen(var id) {
    if (id == HomeScreenID.logOut) {
      _auth.signOut();
    } else if (id == HomeScreenID.test) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TestScreen(
                  dB: widget.dB,
                )),
      );
    } else if (id == HomeScreenID.yourInfo) {
      return _settingModalBottomSheet(context);
    }
  }

  void _settingModalBottomSheet(context) {
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
                  subtitle: Text(add,style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 17, color: Colors.black),)),
                )

              ],
            ),
          );
        });
  }
}
