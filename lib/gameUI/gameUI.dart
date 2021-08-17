import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class GameUI extends StatelessWidget {
  const GameUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 80),
            child: LayoutBuilder(
              builder: (_, constraints) => Container(
                width: constraints.widthConstraints().maxWidth,
                height: constraints.heightConstraints().maxHeight,
                color: Colors.yellow,
                child: CanvasTouchDetector(
                  builder: (context) => (CustomPaint(
                    painter: FaceOutLinePainter(context),
                  )),
                ),
              ),
            )),
      ),
    );
  }
}

class FaceOutLinePainter extends CustomPainter {
  final BuildContext context;
  FaceOutLinePainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    ///creating touch event
    var myCanvas = TouchyCanvas(context, canvas);

    myCanvas.drawLine(
        Offset(0, 0),
        Offset(size.width - 100, size.height - 100),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 50, onTapDown: (tapdetail) {
      print("line touched ");
      // print(tapdetail.localPosition);
    }, onPanUpdate: (detail) {
      // print('Black line Swiped'); //do cooler things here. Probably change app state or animate
    });

    myCanvas.drawCircle(Offset(100, 200), 60, Paint()..color = Colors.orange,
        onTapDown: (tapdetail) {
      print("orange Circle touched ");
      print(tapdetail.localPosition);
    }, onPanDown: (tapdetail) {
      //  print("orange circle swiped");
    });

    ///touch event test end

    //define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.indigoAccent;
    final redPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;

    //canvas.drawCircle(Offset.zero, 20, redPaint);

    //left eye
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(20, 40, 100, 100),
        Radius.circular(20),
      ),
      paint,
    );

    //right eye
    canvas.drawOval(
      Rect.fromLTWH(size.width - 120, 40, 100, 100),
      paint,
    );

    //Mouth
    final mouth = Path();
    mouth.moveTo(size.width * 0.8, size.height * 0.8);
    mouth.arcToPoint(
      Offset(size.width * 0.2, size.height * 0.8),
      radius: Radius.circular(150),
    );

    mouth.arcToPoint(
      Offset(size.width * 0.8, size.height * 0.8),
      radius: Radius.circular(200),
      clockwise: false,
    );

    canvas.drawPath(mouth, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //as we don't need to redraw anything
    return false;
  }
}
