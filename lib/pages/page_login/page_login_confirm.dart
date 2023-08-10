import 'package:aiia/pages/page_chat_screen.dart';
import 'package:aiia/pages/page_login.dart';
import 'package:aiia/data/data_usrInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmLogin extends StatefulWidget {
  final LoginWindowStatus loginWinSta;
  var formKey;
  CurUserData UsrData;
  ConfirmLogin({
    required this.loginWinSta,
    required this.formKey,
    required this.UsrData,
  });

  @override
  State<ConfirmLogin> createState() => _ConfirmLoginState();
}

class _ConfirmLoginState extends State<ConfirmLogin> {
  @override
  final authentication = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn,
      top: widget.loginWinSta.isSignupScreen ? 470 : 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: GestureDetector(
            onTap: () async {
              LoginSignupScreenState? parent = context.findAncestorStateOfType<LoginSignupScreenState>();
              parent!.setState(() {
                parent.LoginWinSta.showSpinner = true;
              });
              if (widget.loginWinSta.isSignupScreen) {
                _tryValidation();

                try {
                  final newUser = await authentication.createUserWithEmailAndPassword(
                    email: widget.UsrData.userEmail,
                    password: widget.UsrData.userPassword,
                  );

                  await FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid).set({
                    'userName': widget.UsrData.userName,
                    'email': widget.UsrData.userEmail,
                  });

                  if (newUser.user != null) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return ChatScreen();
                    //     },
                    //   ),
                    // );
                    LoginSignupScreenState? parent = context.findAncestorStateOfType<LoginSignupScreenState>();
                    parent!.setState(() {
                      widget.loginWinSta.showSpinner = false;
                    });
                  }
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please check your email and password'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                  LoginSignupScreenState? parent = context.findAncestorStateOfType<LoginSignupScreenState>();
                  parent!.setState(() {
                    parent.LoginWinSta.showSpinner = false;
                  });
                }
              }
              if (!widget.loginWinSta.isSignupScreen) {
                _tryValidation();

                try {
                  final newUser = await authentication.signInWithEmailAndPassword(
                    email: widget.UsrData.userEmail,
                    password: widget.UsrData.userPassword,
                  );
                  if (newUser.user != null) {
                    /* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ChatScreen();
                                }),
                              );  */
                    LoginSignupScreenState? parent = context.findAncestorStateOfType<LoginSignupScreenState>();
                    parent!.setState(() {
                      parent.LoginWinSta.showSpinner = false;
                    });
                  }
                } catch (e) {
                  print(e);
                  LoginSignupScreenState? parent = context.findAncestorStateOfType<LoginSignupScreenState>();
                  parent!.setState(() {
                    parent.LoginWinSta.showSpinner = false;
                  });
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purpleAccent,
                      Colors.blue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: Icon(
                Icons.arrow_forward_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _tryValidation() {
    final isValid = widget.formKey.currentState!.validate(); // 폼에 대한 유효성 결과를 리턴할 것이므로 final is valid
    if (isValid) {
      widget.formKey.currentState!.save();
    }
  }
}
