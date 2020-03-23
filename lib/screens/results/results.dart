import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poolish/shared/constants.dart';
import 'package:poolish/screens/results/chart.dart';

class ResultScreen extends StatefulWidget {
  var testList;
  @override
  ResultScreen({Key key,@required this.testList}): super(key: key);
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
            title: Text("Pool Tests",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 40, color: Colors.white),
                )),
            backgroundColor: Colors.white,
            elevation: 0.0,
            flexibleSpace: Container(
                decoration:
                    BoxDecoration(gradient: LinearGradient(colors: gradient)))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: Color.fromRGBO(217, 217, 217, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'Results',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Color.fromRGBO(166, 166, 166, 1.0),
                          fontSize: 20)),
                  // style: ,
                )),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView(
                    children: <Widget>[drawPieChart(), testResultsList()]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, double> dataMap = new Map();
  List<Color> colorList = new List();
  Widget drawPieChart() {
    var keys = widget.testList.keys;
    for (var key in keys) {
      if (widget.testList[key] == null) {
        dataMap.putIfAbsent("Not Tested", () => 0);
        dataMap["Not Tested"] += 1;
      } else if (safeOrNot(key, widget.testList[key])) {
        dataMap.putIfAbsent("Safe", () => 0);
        dataMap["Safe"] += 1;
      } else {
        dataMap.putIfAbsent("Unsafe", () => 0);
        dataMap["Unsafe"] += 1;
      }
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(166, 166, 166, 1.0), blurRadius: 5.0),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15))),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      height: 250,
      child: MyPieChart(dataMap: dataMap),
    );
  }

  Widget testResultsList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(166, 166, 166, 1.0), blurRadius: 5.0),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15))),
      height: 250, // give it a fixed height constraint
      // child ListView
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: widget.testList.length,
          itemBuilder: (BuildContext context, int index) {
            String key = widget.testList.keys.elementAt(index);
            return new Column(
              children: <Widget>[
                testListTile(key, widget.testList[key]),
                Container(
                  height: 1.0,
                  color: Color.fromRGBO(217, 217, 217, 1.0),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget testListTile(key, val) {
    bool safe = safeOrNot(key, val);
    String safety = val == null ? "Not Tested" : safe ? "Safe" : "Unsafe";
    Color colorText = val == null
        ? Color.fromRGBO(166, 166, 166, 1.0)
        : safe ? Colors.green : Colors.red;
    Icon icon = val == null
        ? Icon(Icons.not_interested, color: Color.fromRGBO(166, 166, 166, 1.0))
        : safe
            ? Icon(Icons.check_circle_outline, color: Colors.green)
            : Icon(Icons.cancel, color: Colors.red);
    return Container(
      child: ListTile(
        title: Text(key),
        subtitle: Text(
          safety,
          style: GoogleFonts.poppins(textStyle: TextStyle(color: colorText)),
        ),
        trailing: icon,
      ),
    );
  }
}
