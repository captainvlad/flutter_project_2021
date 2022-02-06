import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;

  const CustomTextWidget({
    Key? key,
    this.size = 0,
    this.text = "",
    this.strokeWidth = 0,
    this.fillColor = whiteColor,
    this.strokeColor = blueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Solid text as fill.
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}
