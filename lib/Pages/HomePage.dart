import 'dart:io';
import 'dart:math';

import 'package:Hava_notlar/Components/Responsive.dart';

import 'package:flutter/material.dart';
import 'package:Hava_notlar/Components/AlertInput.dart';
import 'package:Hava_notlar/Components/AppColors.dart';
import 'package:Hava_notlar/Components/AppText.dart';
import 'package:Hava_notlar/Components/Input.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:Hava_notlar/Components/Settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List menus = ["Hepsi", "Dün"];
  List color_app_note = [
    AppColors.blue,
    AppColors.pink,
    AppColors.yellow,
    AppColors.green,
    AppColors.skin,
    AppColors.red
  ];
  List<String> notes_title = [];
  List<String> notes = [];
  Future<void> isUpdate() async {
    try {
      final response =
          await http.get(Uri.parse(SettingsEnv.apiSendUrl + '/api/update'));
      if (response.statusCode == 200) {
        var test = json.decode(response.body);
        if (test[0]["update"] != 1) {
          print("update available");
          //test ıcın unlemı = yap
        }
      } else {
        print('İstek başarısız oldu: ${response.statusCode}');
      }
    } catch (error) {
      print('Hata: $error');
    }
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse(SettingsEnv.apiSendUrl + '/api/social'));

      if (response.statusCode == 200) {
        var test = json.decode(response.body);
        notes = [];
        notes_title = [];
        for (int x = 0; x < test.length; x++) {
          setState(() {
            if (test[x]["onay"] == 1) {
              notes_title.add(test[x]["title"]
                  .toString()
                  .toLowerCase()
                  .replaceFirst(test[x]["title"][0],
                      test[x]["title"][0].toString().toUpperCase()));

              notes.add(test[x]["text"].toString().toLowerCase().replaceFirst(
                  test[x]["text"][0],
                  test[x]["text"][0].toString().toUpperCase()));
            }

            // notes_title = notes_title.reversed.toList();

            // notes = notes.reversed.toList();
          });
        }
      } else {
        print('basarisiz: ${response.statusCode}');
      }
    } catch (error) {
      print('Hata: $error');
    }
  }

  TextEditingController _title = new TextEditingController();
  TextEditingController _text = new TextEditingController();

  void initState() {
    super.initState();
    fetchData();
    isUpdate();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    TextEditingController _search = new TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: responsive.screenWidth / 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Title(),
              SizedBox(
                height: responsive.screenHeight / 40.25,
              ),
              Expanded(
                child: MasonryGridView.builder(
                    itemCount: notes_title.length,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(
                                color: color_app_note[
                                    index % color_app_note.length],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: responsive.screenHeight / 161,
                                  horizontal: responsive.screenWidth / 76.8),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: responsive.screenHeight / 80.5,
                                          bottom:
                                              responsive.screenHeight / 89.44,
                                          left: responsive.screenWidth / 76.8,
                                          right: responsive.screenWidth / 76.8),
                                      child: AppText(
                                          text: notes_title[index],
                                          fontWeight: FontWeight.w600,
                                          context: context),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: responsive.screenHeight / 80.5,
                                        left: responsive.screenWidth / 76.8,
                                      ),
                                      child: AppText(
                                          text: notes[index], context: context),
                                    )
                                  ]),
                            ),
                          ),
                        )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AlertInput.showAlert(context,
              title: "Mesaj Gönder",
              buttonText: "Send",
              textEditingControllertitle: _title,
              textEditingControllertext: _text);
          setState(() {
            fetchData();
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.black,
      ),
    );
  }

  Row Menu() {
    Responsive responsive = Responsive(context);

    return Row(
      children: [
        Flexible(
          child: Container(
            height: responsive.screenHeight / 30.96,
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: responsive.screenWidth / 38.4),
                  child: AppText(
                      text: menus[index],
                      fontFamily: "Poppins",
                      fontSize: responsive.screenWidth / 32,
                      color: index == 0 ? Colors.white : AppColors.black,
                      context: context),
                )),
                margin: index != 0
                    ? EdgeInsets.only(left: responsive.screenWidth / 32.4)
                    : EdgeInsets.only(left: 0),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.4, color: AppColors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: index == 0 ? AppColors.black : Colors.white,
                ),
              ),
              itemCount: 2,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }

  Padding Search(TextEditingController _search) {
    Responsive responsive = Responsive(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.screenHeight / 44.72),
      child: Input(
        controller: _search,
        prefixIconName: Icons.search,
        prefixIconShow: true,
        fontSize: responsive.screenWidth / 21.3,
        height: responsive.screenHeight / 16.1,
        hint: "Notlarda ara..",
      ),
    );
  }

  Padding Title() {
    Responsive responsive = Responsive(context);

    return Padding(
      padding: EdgeInsets.only(top: responsive.screenHeight / 44.72),
      child: AppText(
          text: "Notes",
          fontSize: responsive.screenWidth / 16,
          fontFamily: "Poppins",
          context: context),
    );
  }
}
