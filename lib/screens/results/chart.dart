import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poolish/screens/results/chart_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:poolish/shared/constants.dart';

class MyPieChart extends StatefulWidget {
  final Map dataMap;
  @override
  MyPieChart({this.dataMap});
  _MyPieChartState createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  int touchedIndex;

  List<Widget> returnLegend() {
    List<String> keys = new List();
    for (var key in widget.dataMap.keys) {
      keys.add(key);
    }

    List<Widget> legendList = new List();

    for (var key = 0; key < keys.length; key++) {
      legendList.add(new Indicator(
        color: keys[key] == "Safe"
            ? (touchedIndex == key ? mainThemeColor:mainThemeColor.withOpacity(0.7))
            : keys[key] == "Unsafe"
                ? (touchedIndex == key ? Colors.red:Colors.red.withOpacity(0.7))
                : (touchedIndex == key ? Color.fromRGBO(166, 166, 166, 1):Color.fromRGBO(166, 166, 166, 1).withOpacity(0.7)),
        text: keys[key],
        isSquare: false,
        size: touchedIndex == key ? 18 : 16,
        textColor: touchedIndex == key
            ? Colors.black
            : Color.fromRGBO(166, 166, 166, 1),
      ));
    }
    return legendList;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: returnLegend()),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    startDegreeOffset: 0,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 6,
                    centerSpaceRadius: 0,
                    sections: showingSections()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<String> keys = new List();
    for (var key in widget.dataMap.keys) {
      keys.add(key);
    }

    return List.generate(
      widget.dataMap.length,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.7;
        switch (keys[i]) {
          case "Safe":
            return PieChartSectionData(
              color: mainThemeColor.withOpacity(opacity),
              value: widget.dataMap[keys[i]],
              title: widget.dataMap[keys[i]].round().toString(),
              radius: isTouched ? 85 : 80,
              titleStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black)),
              titlePositionPercentageOffset: 0.5,
            );
          case "Unsafe":
            return PieChartSectionData(
              color: Colors.red.withOpacity(opacity),
              value: widget.dataMap[keys[i]],
              title: widget.dataMap[keys[i]].round().toString(),
              radius: isTouched ? 85 : 80,
              titleStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black)),
              titlePositionPercentageOffset: 0.5,
            );
          case "Not Tested":
            return PieChartSectionData(
              color: Color.fromRGBO(166, 166, 166, 1).withOpacity(opacity),
              value: widget.dataMap[keys[i]],
              title: widget.dataMap[keys[i]].round().toString(),
              radius: isTouched ? 85 : 80,
              titleStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.black)),
              titlePositionPercentageOffset: 0.5,
            );
          default:
            return null;
        }
      },
    );
  }
}
