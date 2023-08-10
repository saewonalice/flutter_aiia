// import 'dart:io';
// import 'package:aiia/add_image/add_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:aiia/pages/page_chat_screen.dart';//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:aiia/data/data_usrInfo.dart';
import 'package:aiia/pages/page_login/page_login_confirm.dart';
import 'package:aiia/pages/page_login/page_login_userinfo.dart';
import 'package:flutter/material.dart';
import 'package:aiia/config/palette.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:aiia/pages/page_login/page_login_background.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  State<LoginSignupScreen> createState() => LoginSignupScreenState();
}

class LoginSignupScreenState extends State<LoginSignupScreen> {
  LoginWindowStatus LoginWinSta = new LoginWindowStatus();
  final _formKey = GlobalKey<FormState>();
  // 모든 폼 위에 validation이  작동돼야 하므로 formstate이 돼야함.
  CurUserData UsrData = new CurUserData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.facebookColor,
      body: ModalProgressHUD(
        inAsyncCall: LoginWinSta.showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              LoginBackGround(loginWinSta: LoginWinSta), // 배경
              UsrInput(loginWinSta: LoginWinSta, UsrData: UsrData,formKey: _formKey,), //텍스트 폼 필드
              ConfirmLogin(loginWinSta: LoginWinSta, formKey: _formKey, UsrData: UsrData), // 다음 페이지 이동버튼
            ],
          ),
        ),
      ),
    );
  }
}
