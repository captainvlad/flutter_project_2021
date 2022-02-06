import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';

class CustomCardWidget extends StatelessWidget {
  final Color color;
  final Widget? label;
  final double width;
  final double height;
  final double cornerRaidus = 10;

  const CustomCardWidget({
    Key? key,
    this.label,
    this.color = yellowColor,
    this.width = 0,
    this.height = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(cornerRaidus),
          ),
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }
}
