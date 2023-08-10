import 'package:aiia/config/palette.dart';
import 'package:aiia/data/data_usrInfo.dart';
import 'package:aiia/pages/page_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsrInput extends StatefulWidget {
  @override
  final LoginWindowStatus loginWinSta;
  CurUserData UsrData;
  var formKey;

  UsrInput({required this.loginWinSta, required this.UsrData, required this.formKey});

  State<UsrInput> createState() => _UsrInputState();
}

class _UsrInputState extends State<UsrInput> {
  @override
  final authentication = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn,
      top: 220,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
        padding: EdgeInsets.all(20.0),
        height: widget.loginWinSta.isSignupScreen ? 280.0 : 250.0,
        width: MediaQuery.of(context).size.width - 40,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, spreadRadius: 5),
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      LoginSignupScreenState? parent = context.findAncestorStateOfType<LoginSignupScreenState>();
                      parent!.setState(() {
                        parent.LoginWinSta.isSignupScreen = false;
                        // widget.loginWinSta.isSignupScreen = false;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'LOG IN',
                          style: TextStyle(
                              fontFamily: 'ShantellSans',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: !widget.loginWinSta.isSignupScreen ? Palette.activeColor : Palette.textColor1),
                        ),
                        if (!widget.loginWinSta.isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            height: 2,
                            width: 55,
                            color: Colors.grey,
                          )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      LoginSignupScreenState? parent = context.findAncestorStateOfType<LoginSignupScreenState>();
                      parent!.setState(() {
                        parent.LoginWinSta.isSignupScreen = true;
                      });
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontFamily: 'ShantellSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: widget.loginWinSta.isSignupScreen ? Palette.activeColor : Palette.textColor1),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        if (widget.loginWinSta.isSignupScreen)
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 15, 0),
                            height: 2,
                            width: 55,
                            color: Colors.grey,
                          )
                      ],
                    ),
                  )
                ],
              ),
              if (widget.loginWinSta.isSignupScreen)
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Form(
                    key: widget.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: ValueKey(1),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.UsrData.userName = value!;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Palette.iconColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              hintText: 'User name',
                              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                              contentPadding: EdgeInsets.all(10)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey(2),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.UsrData.userEmail = value!;
                          },
                          onChanged: (value) {
                            widget.UsrData.userEmail = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Palette.iconColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              hintText: 'email',
                              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                              contentPadding: EdgeInsets.all(10)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          obscureText: true,
                          key: ValueKey(3),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Password must be at least 7 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.UsrData.userPassword = value!;
                          },
                          onChanged: (value) {
                            widget.UsrData.userPassword = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Palette.iconColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              hintText: 'password',
                              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                              contentPadding: EdgeInsets.all(10)),
                        ),
                      ],
                    ),
                  ),
                ),
              if (!widget.loginWinSta.isSignupScreen)
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Form(
                    key: widget.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: ValueKey(4),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.UsrData.userEmail = value!;
                          },
                          onChanged: (value) {
                            widget.UsrData.userEmail = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Palette.iconColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              hintText: 'email',
                              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                              contentPadding: EdgeInsets.all(10)),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          key: ValueKey(5),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Password must be at least 7 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            widget.UsrData.userPassword = value!;
                          },
                          onChanged: (value) {
                            widget.UsrData.userPassword = value;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Palette.iconColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Palette.textColor1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35.0),
                                ),
                              ),
                              hintText: 'password',
                              hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                              contentPadding: EdgeInsets.all(10)),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
