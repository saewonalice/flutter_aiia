import 'package:aiia/chat/new_message.dart';
import 'package:aiia/config/palette.dart';
// import 'package:aiia/pages/Member.dart';
import 'package:aiia/pages/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aiia/chat/message.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'account_used.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final authentication = FirebaseAuth.instance;
  User? loggedUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Chat Room',
          style: TextStyle(
            fontFamily: 'ShantellSans',
            letterSpacing: 2.0,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              authentication.signOut();
              // Navigator.pop(context);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 50, bottom: 200),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.indigo[100],
                ),
                child: Expanded(
                  child: Messages(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(50),
                      //   topRight: Radius.circular(50),
                      //   bottomLeft: Radius.circular(50),
                      //   bottomRight: Radius.circular(50),
                      // ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: NewMessage(),
                    )),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ],
      ),
      drawer: customdrawer(),
    );
  }

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }
}
