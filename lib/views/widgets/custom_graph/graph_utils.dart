import 'dart:math';
import 'dart:ui';

List<Offset> calculateLocationInCanvas({required Size canvasSize, required List<int> dataY}) {
  List<Offset> retval = <Offset>[];

  final maxValue = dataY.reduce((value, element) => max(value, element));
  final minValue = dataY.reduce((value, element) => min(value, element));
  List<double> dataFraction =
      dataY.map((e) => (e - minValue) / (maxValue - minValue)).toList();

  const double minWidth = 20.0;
  final double maxWidth = canvasSize.width - 20.0;
  final double minHeight = canvasSize.height * .8;
  final double maxHeight = canvasSize.height * .5;
  final double widthStep = (maxWidth - minWidth) / (dataFraction.length - 1);

  var xPos = minWidth;
  for (int i = 0; i < dataFraction.length; i++) {
    double x = xPos;
    double y = minHeight + dataFraction[i] * (maxHeight - minHeight);
    xPos += widthStep;
    retval.add(Offset(x, y));
  }

  return retval;
}
