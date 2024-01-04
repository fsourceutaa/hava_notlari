import 'package:flutter/material.dart';
import 'package:Hava_notlar/Components/AppColors.dart';

Widget Input({
  double borderRadius = 16,
  double width = double.infinity,
  double height = 60,
  double left = 0,
  double right = 0,
  double top = 0,
  double bottom = 0,
  String hint = "",
  double fontSize = 16,
  bool prefixIconShow = false,
  bool suffixIconShow = false,
  IconData prefixIconName = Icons.person,
  IconData suffixIconName = Icons.lock,
  TextInputType textInputType = TextInputType.text,
  Color color = AppColors.black,
  required TextEditingController controller,
  bool password = false,
}) {
  return Visibility(
    visible: true,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border:
              Border.all(color: color, width: 0.2, style: BorderStyle.solid)),
      width: width,
      height: height,
      child: Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: TextField(
            textAlign: TextAlign.left,
            keyboardType: textInputType,
            controller: controller,
            obscureText: password,
            cursorColor: color,
            style: TextStyle(
                fontSize: fontSize,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w200,
                color: AppColors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              suffixIcon: suffixIconShow
                  ? Icon(
                      suffixIconName,
                      color: color,
                    )
                  : null,
              prefixIcon: prefixIconShow
                  ? Icon(
                      prefixIconName,
                      color: color,
                    )
                  : null,
            )),
      ),
    ),
  );
}
