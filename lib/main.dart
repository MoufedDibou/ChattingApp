// ignore_for_file: prefer_const_constructors

import 'package:chatting_application/UiPages/Chat_Page.dart';
import 'package:chatting_application/UiPages/Login_Page.dart';
import 'package:chatting_application/UiPages/Start_page.dart';
import 'package:chatting_application/UiPages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // these two rows must be added to enable firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: StartPage(),
      routes: {
        '/Login': (c) => LoginPage(),
        '/Register': (c) => RegisterPage(),
        '/Chat': (c) => ChatPage(),
        '/Start': (c) => StartPage()
      },
    );
  }
}
