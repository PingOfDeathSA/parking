import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSfTrackShape extends SfTrackShape {
  @override
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
      required dynamic themeData, // Use the appropriate theme class here
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Animation<double> enableAnimation,
      required Paint? inactivePaint,

      required Paint? activePaint,
      required TextDirection textDirection}) {
    Paint paint = Paint()
      ..color = themeData.activeTrackColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    super.paint(context, offset, thumbCenter, startThumbCenter, endThumbCenter,
        parentBox: parentBox,
        themeData: themeData,
        enableAnimation: enableAnimation,
        inactivePaint: inactivePaint,
        activePaint: paint,
        textDirection: textDirection);
  }
}
