import 'package:flutter/cupertino.dart';
import 'package:Hava_notlar/Components/AppColors.dart';

Text AppText({
  required String text,
  String fontFamily = "Poppins",
  Color color = AppColors.black,
  FontWeight fontWeight = FontWeight.normal,
  required BuildContext context,
  double fontSize = 14.0,
}) {
  if (fontSize == 14.0) {
    fontSize = MediaQuery.of(context).size.width / 27.42;
  }
  return Text(
    text,
    style: TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}
