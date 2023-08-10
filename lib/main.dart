import 'package:aiia/firebase/firebase_options.dart';
import 'package:aiia/navi_screen.dart';
import 'package:aiia/pages/page_chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aiia/pages/page_login.dart';
import 'package:firebase_auth/firebase_auth.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AzIt',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context,snapshot){
          if(snapshot.hasData){
            return NaviScr();
          }
          return LoginSignupScreen();
        },
      ), // home 에서 불러오기
    );
  }
}
