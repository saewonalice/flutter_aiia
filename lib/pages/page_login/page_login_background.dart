import 'package:aiia/data/data_usrInfo.dart';
import 'package:flutter/material.dart';

class LoginBackGround extends StatelessWidget {
  final LoginWindowStatus loginWinSta;
  LoginBackGround({required this.loginWinSta});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/logo.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Welcome to AIIA',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 25,
                    fontFamily: 'ShantellSans',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),

                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                loginWinSta.isSignupScreen
                    ? 'Sign up to join us!'
                    : 'good to see you again',
                style: TextStyle(
                  fontFamily: 'ShantellSans',
                  letterSpacing: 1.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
