import 'package:Hava_notlar/Components/Responsive.dart';
import 'package:flutter/material.dart';
import 'package:Hava_notlar/Components/AppColors.dart';
import 'package:Hava_notlar/Components/AppText.dart';
import 'package:Hava_notlar/Components/Input.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Hava_notlar/Components/Settings.dart';

class AlertInput {
  static void showAlert(
    BuildContext context, {
    String title = "",
    String content = "",
    String buttonText = "",
    required TextEditingController textEditingControllertitle,
    required TextEditingController textEditingControllertext,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Responsive responsive = Responsive(context);

        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontFamily: "Poppins"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: responsive.screenHeight / 80.5,
              ),
              AppText(text: "Başlık:", context: context),
              SizedBox(
                height: responsive.screenHeight / 161,
              ),
              Input(
                  controller: textEditingControllertitle,
                  height: responsive.screenHeight / 16.1,
                  left: responsive.screenWidth / 76.8,
                  borderRadius: 5,
                  right: responsive.screenWidth / 76.8),
              SizedBox(
                height: responsive.screenWidth / 40.25,
              ),
              AppText(text: "İçerik:", context: context),
              SizedBox(
                height: responsive.screenHeight / 161.0,
              ),
              Input(
                  controller: textEditingControllertext,
                  height: responsive.screenHeight / 16.1,
                  left: responsive.screenWidth / 76.8,
                  borderRadius: 5,
                  right: responsive.screenWidth / 76.8),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                buttonText,
                style: TextStyle(fontFamily: "Poppins", color: AppColors.black),
              ),
              onPressed: () {
                Future<void> postData() async {
                  final response = await http.post(
                    Uri.parse(SettingsEnv.apiSendUrl + '/api/socialpost'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, dynamic>{
                      'title': textEditingControllertitle.text
                          .toString()
                          .toLowerCase(),
                      'text': textEditingControllertext.text
                          .toString()
                          .toLowerCase(),
                    }),
                  );

                  if (response.statusCode == 201) {
                    final Map<String, dynamic> data =
                        json.decode(response.body);
                    print(data);
                  } else {
                    print('İstek başarısız oldu: ${response.statusCode}');
                  }
                }

                postData();
                Navigator.of(context).pop();
                textEditingControllertext.text = "";
                textEditingControllertitle.text = "";
              },
            ),
          ],
        );
      },
    );
  }
}
