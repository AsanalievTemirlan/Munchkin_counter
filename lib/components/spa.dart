import 'package:flutter/cupertino.dart';

Widget vSpa(double? height) => SizedBox(height: height ?? 10);
Widget hSpa(double? width) => SizedBox(width: width ?? 10);
Widget allSpa(double? width, double? height) => SizedBox(width: width ?? 10, height: height ?? 10,);