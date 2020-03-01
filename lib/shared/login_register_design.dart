
import 'package:flutter/material.dart';
import 'dart:math';

class CurvedShape extends StatelessWidget {
  final curveHeightCS;
  CurvedShape({this.curveHeightCS});
  @override

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: curveHeightCS,
      child: CustomPaint(
        painter: _MyPainter(avatarRadiusP: curveHeightCS * 0.2),

          child:Container(
            
            
            child: Align(
              alignment: FractionalOffset(0.5, 0.3),
              child:Text(
              "Poolish",
              
              style: TextStyle(fontSize: curveHeightCS*0.3,
              fontFamily: 'DancingScript',
              color: Colors.white),
            )
            ),

            
          )
        
        ,
      ),
    );
  }
}





class _MyPainter extends CustomPainter {
  final avatarRadiusP;
  _MyPainter({this.avatarRadiusP});
  @override
  void paint(Canvas canvas, Size size) {

      var gradient = LinearGradient(
      //center: const Alignment(0.7, -0.6),
      colors: [Color.fromRGBO(69, 211, 193,0.8), Color.fromRGBO(69, 211, 193,0.2)],
      stops: [0.5, 1.0],
    );
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color =  Color.fromRGBO(69, 211, 193,0.8)
      ..shader = gradient.createShader(Offset.zero & size);


    Offset circleCenter = Offset(size.width / 2, size.height - avatarRadiusP);

    Offset topLeft = Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height * 0.5);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height * 0.5);

    Offset leftCurveControlPoint = Offset(circleCenter.dx * 0.5, size.height - avatarRadiusP);
    Offset rightCurveControlPoint = Offset(circleCenter.dx * 1.6, size.height - avatarRadiusP);

    final arcStartAngle = 200 / 180 * pi;
    final avatarLeftPointX = circleCenter.dx + avatarRadiusP * cos(arcStartAngle);
    final avatarLeftPointY = circleCenter.dy + avatarRadiusP * sin(arcStartAngle);
    Offset avatarLeftPoint = Offset(avatarLeftPointX, avatarLeftPointY); // the left point of the arc

    final arcEndAngle = -5 / 180 * pi;
    final avatarRightPointX = circleCenter.dx + avatarRadiusP * cos(arcEndAngle);
    final avatarRightPointY = circleCenter.dy + avatarRadiusP * sin(arcEndAngle);
    Offset avatarRightPoint = Offset(avatarRightPointX, avatarRightPointY); // the right point of the arc

    Path path = Path()
      ..moveTo(topLeft.dx, topLeft.dy) // this move isn't required since the start point is (0,0)

      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy, avatarLeftPoint.dx, avatarLeftPoint.dy)
      ..arcToPoint(avatarRightPoint, radius: Radius.circular(avatarRadiusP))
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy, bottomRight.dx, bottomRight.dy)

      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}