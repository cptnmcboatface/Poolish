import 'package:flutter/material.dart';
import 'package:poolish/shared/constants.dart';




class TestScreen extends StatefulWidget {
  
  TestScreen();
  //@override
  
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Widget build(BuildContext context) {
    List <String> colors=["EB596A", "ED636A", "ED7B67", "ECA16E", "D5B663", "ACB460", "8FA460"];
    int a=0;
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text(
        "Pool Tests",
        style: TextStyle(
            fontSize: 40,
            fontFamily: 'GlacielIndifference',
            color: Colors.white),
        ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: gradient)))
          ),

      body: myW(colors, a)
    );

      //myW();
  }
}

Widget myW(List colors, int iter){
  int numberRows = ((colors.length)/3).ceil();
  print (numberRows);
  List<Widget> rows = new List();

  for( var i = 0 ; i <numberRows ; i++) {

     rows.add(rowWidget(colors, iter));
     iter=iter+3;
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: rows
  );
}



Widget rowWidget(List colors, int iter){
  int numberTiles = 3;
  int rem= colors.length-iter;
  if (rem < 3){
    numberTiles=rem;
  }

  List<Widget> tiles = new List();
  for( var i = 0 ; i <numberTiles ; i++) {
    tiles.add(tileWidget(colors, iter));
    iter=iter+1;
  }

  return new Container(
    height: 100,
    margin: EdgeInsets.all(10.0),

    child: new Row(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tiles,
    ),
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


Widget tileWidget(List colors, int iter){
  String c= colors[iter];
  print (c);
  final Color col = HexColor(c);
  print (col);

   return new Container(
   // padding: EdgeInsets.symmetric(horizontal: 1),
    height: double.infinity,
    width: 100,
    color: col,
    child: FlatButton(onPressed: (){}, child: null)

    );
}
