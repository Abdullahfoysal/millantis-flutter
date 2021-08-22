import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: BodyWidget(),
        ),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  List<Offset> _points = <Offset>[];
  void callBack(Offset point) {
    print("method invoke from canvas custom paint");
    print(point);
    setState(() {
      _points.add(point);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) => Container(
          width: constraints.widthConstraints().maxWidth,
          height: constraints.heightConstraints().maxHeight,
          color: Colors.yellow,
          child: CanvasTouchDetector(
            builder: (context) => (CustomPaint(
              painter: Signature(
                  points: _points, onCallback: callBack, context: context),
            )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.cleaning_services_rounded),
        onPressed: () {
          _points.clear();
        },
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Offset> points;
  final Function onCallback;
  final BuildContext context;
  Signature(
      {required this.points, required this.onCallback, required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    ///creating touch event
    var myCanvas = TouchyCanvas(context, canvas);

    /*myCanvas.drawLine(
        Offset(0, 0),
        Offset(size.width - 100, size.height - 100),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 50, onTapDown: (tapdetail) {
      print("line touched ");
      // onCallback(tapdetail.localPosition);
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
    });*/

    ///touch event test end

    Paint paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < 5; i++) {
      double height = size.height / 3 + 50 * i;
      for (int j = 0; j < 5; j++) {
        double width = size.width / 3 + 50 * j;
        myCanvas.drawCircle(
            Offset(width, height), 15.0, Paint()..color = Colors.pink,
            onTapDown: (tapdetail) {
          print("pink Circle touched ");
          onCallback(tapdetail.localPosition);
          print(tapdetail.localPosition);
        }, onPanDown: (tapdetail) {
          //  print("orange circle swiped");
        });
      }
    }

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) {
    return oldDelegate.points != points;
  }
}

/*
class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          color: Colors.yellow,
          child: BodyWidget(),
        ),
      ),
    );
  }
}

 */
