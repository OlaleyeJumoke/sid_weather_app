import "package:flutter/material.dart";
import 'package:sid_weather_app/views/constants/colors.dart';

import 'custom_painter.dart';
import 'graph_utils.dart';

Widget _buildGraphLabels({
 required BoxConstraints constraints,
 required List<int> dataY,
 required List<String> labelImageUrls,
 required List<String> labelTexts,
}) {
  List<Offset> locationInCanvas = calculateLocationInCanvas(
      canvasSize: Size(constraints.maxWidth, constraints.maxHeight),
      dataY: dataY);
  return Stack(
    children: [
      ...locationInCanvas.asMap().entries.map((entry) {
        var loc = entry.value;
        var index = entry.key;
        return Positioned(
          left: loc.dx - 20.0,
          top: loc.dy - 80.0,
          child: Column(
            children: [
              Image(
                image: NetworkImage(labelImageUrls[index]),
              ),
              Text(
                "${dataY[index]}°",
                style:const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColors.black,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      ...locationInCanvas.asMap().entries.map((entry) {
        var loc = entry.value;
        var index = entry.key;
        return Positioned(
          left: loc.dx - 14.0,
          top: loc.dy + 10.0,
          child: Text(labelTexts[index],
              style:const TextStyle(
                color: CustomColors.gray,
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
              )),
        );
      }).toList(),
    ],
  );
}

Widget buildGraph(
    {required List<int> dataY,
    required int highlightedIndex,
    required List<String> labelImageUrls,
    required List<String> labelTexts}) {
  final GraphLinePainter graphLinePainter =
      GraphLinePainter(dataY: dataY, highlightedIndex: highlightedIndex);

  return Expanded(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 15.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(
            painter: graphLinePainter,
            child: _buildGraphLabels(
              constraints: constraints,
              dataY: dataY,
              labelImageUrls: labelImageUrls,
              labelTexts: labelTexts,
            ),
          );
        },
      ),
    ),
  );
}
