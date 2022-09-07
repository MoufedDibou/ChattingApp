// ignore_for_file: prefer_const_constructors

import 'package:chatting_application/UiElements/button_shape.dart';
import 'package:chatting_application/UiPages/Login_Page.dart';
import 'package:chatting_application/UiPages/register_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset('images/img1.png'),
                  height: 165,
                ),
                Text(
                  "Free Chats",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
              name: "logIn",
              color: Colors.yellow[800]!,
              onPressed: () {
                //     Navigator.pushNamed(context, '/Login');

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            MyButton(
                name: "Register",
                color: Colors.orange[800]!,
                onPressed: () {
                  //  Navigator.pushNamed(context, '/Register');

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                })
          ],
        ),
      ),
    );
  }
}
