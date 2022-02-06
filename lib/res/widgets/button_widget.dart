import 'package:flutter/material.dart';
import 'package:sequel/res/values/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final Color color;
  final Widget? label;
  final double width;
  final double height;
  final Function? onTap;
  final double cornerRaidus = 10;

  const CustomButtonWidget({
    Key? key,
    this.label,
    this.onTap,
    this.color = yellowColor,
    this.width = 0,
    this.height = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(cornerRaidus),
        ),
      ),
      child: MaterialButton(
        onPressed: (() => onTap!.call()),
        child: label,
      ),
    );
  }
}
