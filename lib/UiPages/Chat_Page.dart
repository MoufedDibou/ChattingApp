// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _auth = FirebaseAuth.instance;

  final messageController = TextEditingController();

  late User signedUser;
  String? messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        signedUser = user;
        print(signedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _fireStore.collection('Messages').get();

  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

// this method will return all data in this collection and any change in it will be given immediately
  void messageStream() async {
    await for (var snapshot in _fireStore.collection('Messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset(
              'images/img1.png',
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Free Chat')
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilderWid(),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.orange, width: 2),
              )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      hintText: "type the message",
                      border: InputBorder.none,
                    ),
                  )),
                  TextButton(
                      onPressed: () {
                        messageController.clear();
                        _fireStore.collection('Messages').add(
                            {'text': messageText, 'sender': signedUser.email});
                      },
                      child: Text("Send",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamBuilderWid extends StatelessWidget {
  const StreamBuilderWid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('Messages').snapshots(),
        builder: (context, snapshot) {
          List<MessageDecor> messagesWidgets = [];

          if (!snapshot.hasData) {
            // spinner
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.orangeAccent,
              ),
            );
          }

          final messages = snapshot.data!.docs;

          for (var message in messages) {
            final messageBody = message.get('text');
            final messagesender = message.get('sender');
            final messageWidget = MessageDecor(
              text: messageBody,
              sender: messagesender,
            );

            messagesWidgets.add(messageWidget);
          }

          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messagesWidgets,
            ),
          );
        });
  }
}

class MessageDecor extends StatelessWidget {
  MessageDecor({this.text, this.sender});

  final String? text;
  final String? sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          '$sender',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          color: Colors.blueAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              '$text ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ]),
    );
    ;
  }
}
