import 'package:flutter/material.dart';

class Responsive {
  late BuildContext context;
  late double screenHeight;
  late double screenWidth;
  Responsive(BuildContext context) {
    this.context = context;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}
