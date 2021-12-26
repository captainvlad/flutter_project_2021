import 'package:flutter/material.dart';

class UiManager {
  late double screenWidth;
  late double screenHeight;
  late double blockSizeHorizontal;
  late double blockSizeVertical;

  UiManager(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  static Widget getText({
    String text = "",
    double size = 10,
    double strokeWidth = 6,
    Color fillColor = Colors.white,
    Color strokeColor = Colors.white,
  }) {
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

  static Widget getButton({
    required Widget label,
    required double width,
    required double height,
    required Color color,
    required double cornerRaidus,
    required Function onTap,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(
            cornerRaidus,
          ),
        ),
      ),
      child: MaterialButton(
        onPressed: (() {
          onTap();
        }),
        child: label,
      ),
    );
  }

  static Widget getCard({
    required Widget label,
    required double width,
    required double height,
    required Color color,
    required double cornerRaidus,
  }) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }
}
