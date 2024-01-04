import 'package:flutter/material.dart';
import 'package:Hava_notlar/Pages/HomePage.dart';

void main(List<String> args) {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => HomePage(),
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}
