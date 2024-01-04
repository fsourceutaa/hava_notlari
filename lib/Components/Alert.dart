import 'package:Hava_notlar/Components/Settings.dart';
import 'package:flutter/material.dart';
import 'package:Hava_notlar/Components/AppColors.dart';
import 'package:http/http.dart' as http;

class Alert {
  static void showAlert(BuildContext context,
      {String title = "", String content = "", String buttonText = ""}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontFamily: "Poppins"),
          ),
          content: Text(
            content,
            style: TextStyle(fontFamily: "Poppins"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                buttonText,
                style: TextStyle(fontFamily: "Poppins", color: AppColors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
