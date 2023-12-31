import 'package:flutter/material.dart';
import 'package:sid_weather_app/views/constants/colors.dart';

import 'graph_utils.dart';

class GraphLinePainter extends CustomPainter {
  /*
    Draw the graph line
    Painting images from here can be tricky
    So its better to use the Flutter Widgets as the child of CustomPaint widget
    Stack widget with positioned child can be used to put such widget
    in the exact location.
   */
  int highlightedIndex;
  List<int> dataY;

  GraphLinePainter({required this.dataY,required this.highlightedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = CustomColors.red;
    paint.strokeWidth = 1.0;
    paint.style = PaintingStyle.stroke;

    List<Offset> locationInCanvas =
        calculateLocationInCanvas(canvasSize: size, dataY: dataY);

    // draw line
    var path = Path();
    for (int i = 0; i < locationInCanvas.length; i++) {
      if (i == 0) {
        Offset pos = locationInCanvas[i];
        path.moveTo(pos.dx, pos.dy);
        continue;
      }
      Offset pos = locationInCanvas[i];
      path.lineTo(pos.dx, pos.dy);
    }
    canvas.drawPath(path, paint);

    // draw circle on a line
    Offset circlePos = locationInCanvas[highlightedIndex];
    paint.style = PaintingStyle.fill;
    paint.color = CustomColors.lightRed;
    canvas.drawCircle(circlePos, 11.0, paint);
    paint.color = CustomColors.red;
    canvas.drawCircle(circlePos, 5.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
