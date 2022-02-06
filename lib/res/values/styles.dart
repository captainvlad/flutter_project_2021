import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

TextStyle defaultTextStyle = TextStyle(
  fontSize: 30.0,
  foreground: Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..color = Colors.yellow,
);

SystemUiOverlayStyle appTheme = SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: blueColor,
  statusBarColor: blueColor,
);
