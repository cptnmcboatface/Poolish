import 'package:flutter/material.dart';
import 'package:poolish/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';


class ColorTestScreen extends StatefulWidget {
  final String testName;
  final String val;
  final Function updateVal;
  ColorTestScreen({Key key, @required this.testName,@required this.updateVal,@required this.val}) : super(key: key);
  //@override

  
  @override
  _ColorTestScreenState createState() => _ColorTestScreenState();
}

class _ColorTestScreenState extends State<ColorTestScreen> {
  Widget build(BuildContext context) {
    List <String> colors=colorCodes[widget.testName];
    int a=0;
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text(
        widget.testName,
        style: GoogleFonts.poppins(textStyle:TextStyle(
            fontSize: 40,
            color: Colors.white))
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
    margin: EdgeInsets.all(10.0),

    child: new Row(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tiles,
    ),
  );
}


Widget tileWidget(List colors, int iter){
  String c= colors[iter];
  
  final Color col = HexColor(c);

   return new Container(
    decoration: BoxDecoration(
      color: col,
      border: Border.all(width: 1.5,color:c==widget.val? mainThemeColor:Colors.black,),
  
    borderRadius: BorderRadius.all(Radius.circular(1.0))
    ), 
    height: c==widget.val?110:100,
    width: c==widget.val?110:100,
    
    child: FlatButton(onPressed: () async {

      widget.updateVal(widget.testName,c);
      Navigator.pop(context);       
    }, child: null)

    );
}
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

