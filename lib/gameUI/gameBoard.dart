import 'dart:math';

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
  List<List<int>> lines = new List.generate(25, (i) => []);
  int circleNumber1 = 0;

  void selectCircle1CallBack(int circle1) {
    setState(() {
      circleNumber1 = circle1;
    });
  }

  void callBack(int circleNumber1, int circleNumber2) {
    print("method invoke from canvas custom paint");
    // print(point);
    setState(() {
      if (lines[circleNumber1].isEmpty)
        lines[circleNumber1].add(circleNumber1);
      else {
        for (int i = 0; i < lines[circleNumber1].length; i++) {
          int tempCircle = lines[circleNumber1][i];
          if (tempCircle == circleNumber2) {
            return;
          }
        }
        lines[circleNumber1].add(circleNumber2);
      }
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
                  lines: lines,
                  selectedCircle1: circleNumber1,
                  onCallback: callBack,
                  onselectCircle1CallBack: selectCircle1CallBack,
                  context: context),
            )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.cleaning_services_rounded),
        onPressed: () {
          lines.forEach((element) {
            element.clear();
          });
        },
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<List<int>> lines;
  final Function onCallback;
  final Function onselectCircle1CallBack;
  final BuildContext context;
  int rowColum = 5;
  double circleRadius = 15.0;
  List<Offset> circlePoints = <Offset>[];
  Map circleNumberToOffsetMap = new Map();
  final selectedCircle1;
  Signature(
      {required this.lines,
      required this.selectedCircle1,
      required this.onCallback,
      required this.onselectCircle1CallBack,
      required this.context});

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

    for (int i = 0; i < rowColum; i++) {
      double height = size.height / 3 + 50 * i;
      for (int j = 0; j < rowColum; j++) {
        double width = size.width / 3 + 50 * j;
        int circleNumber = (rowColum * i) + j;
        circleNumberToOffsetMap[circleNumber] = Offset(width, height);

        myCanvas.drawCircle(
          Offset(width, height),
          circleRadius,
          Paint()..color = Colors.pink,
          onPanStart: (tapdetail) {
            print("on start");
            int selectedCircle = getCenter(tapdetail.localPosition);
            print(selectedCircle);
          },
          onPanUpdate: (tapdetail) {
            print("on update");
            int selectedCircle = getCenter(tapdetail.localPosition);
            print(selectedCircle1);
            print(selectedCircle);

            if (isValidLine(selectedCircle)) {
              onCallback(selectedCircle1, selectedCircle);
              onCallback(selectedCircle, selectedCircle1);
            }
          },
          onPanDown: (tapdetail) {
            print("on panDown");
            int selectedCircle = getCenter(tapdetail.localPosition);
            print(selectedCircle);
            onselectCircle1CallBack(selectedCircle);
          },
        );
      }
    }
    // print(circleNumberToOffsetMap);
    print(lines);

    for (int i = 0; i < lines.length; i++) {
      int circle1 = i;
      for (int j = 0; j < lines[i].length; j++) {
        int circle2 = lines[i][j];

        canvas.drawLine(circleNumberToOffsetMap[circle1],
            circleNumberToOffsetMap[circle2], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) {
    return oldDelegate.lines != lines;
  }

  int getCenter(Offset local) {
    for (int i = 0; i < circleNumberToOffsetMap.length; i++) {
      double x1 = local.dx;
      double y1 = local.dy;

      double x2 = circleNumberToOffsetMap[i].dx;
      double y2 = circleNumberToOffsetMap[i].dy;

      x1 = (x1 - x2);
      x1 = x1 * x1;
      y1 = (y1 - y2);
      y1 = y1 * y1;
      double radius = sqrt(x1 + y1);

      if (radius <= circleRadius) {
        return i;
      }
    }
    return -1;
  }

  bool isValidLine(int n) {
    int left = n - 1;
    int right = n + 1;
    int mod = n % rowColum;
    int lineNumber = ((n / rowColum).toInt());

    int up = ((lineNumber - 1) * rowColum) + mod;
    int down = ((lineNumber + 1) * rowColum) + mod;

    if (left == selectedCircle1 ||
        right == selectedCircle1 ||
        up == selectedCircle1 ||
        down == selectedCircle1) {
      return true;
    }
    return false;
  }
}
