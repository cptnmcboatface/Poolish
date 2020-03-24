import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poolish/screens/results/results.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poolish/services/database.dart';
import 'package:poolish/shared/constants.dart';

class History extends StatefulWidget {
  final DatabaseService dB;
  @override
  History({this.dB});
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TestScreen SCREEN",
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
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
                decoration:
                    BoxDecoration(gradient: LinearGradient(colors: gradient)))),
        body: Container(
            child: StreamBuilder<DocumentSnapshot>(
                stream: widget.dB.testList,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Text("Error Connecting to the Internet",
                          style: errorStyle),
                    );
                  DocumentSnapshot docs = snapshot.data;
                  var userTests = docs.data;
                  List<String> keys = userTests.keys.toList();
                  keys.map(DateTime.parse);
                  keys.sort();
                  keys = keys.reversed.toList();
                  keys.removeWhere((item) => !userTests[item]["completed"]);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          color: Color.fromRGBO(217, 217, 217, 1.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Here are all your past tests',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Color.fromRGBO(166, 166, 166, 1.0),
                                    fontSize: 20)),
                            // style: ,
                          )),
                      Expanded(
                        child: keys.length > 0
                            ? Container(
                                // height: 400,
                                child: new ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: keys.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String key = keys.elementAt(index);
                                    return new Column(
                                      children: <Widget>[
                                        myListTile(
                                            key, userTests[key]["testVal"]),
                                        // listTile(key, testResults[key]),
                                        Container(
                                          height: 5.0,
                                          color: Color.fromRGBO(
                                              217, 217, 217, 1.0),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text("You Currently dont have any past tests",style: GoogleFonts.poppins(),),
                            ),
                      )
                    ],
                  );
                })),
      ),
    );
  }

  Widget myListTile(var key, var dataMap) {
    var dateTime = key.split(" ");
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      title: Text(
        dateTime[0],
        style: GoogleFonts.poppins(),
      ),
      subtitle: Text(dateTime[1]),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(
                    dB: widget.dB,
                    resultKey: key,
                    mode: 1,
                    testList: dataMap,
                  )),
        );
      },
    );
  }
}
