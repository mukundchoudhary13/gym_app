// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/Constants/constant.dart';
import 'package:gym_app/Constants/widget.dart';
import 'package:gym_app/Services/Firebase/auth_exception.dart';
import 'package:gym_app/Services/Firebase/auth_functions.dart';
import 'package:gym_app/Services/Firebase/database_functions.dart';
import 'package:gym_app/views/Credential_Pages/Credential_Pages/signin_page/forget_password.dart';
import 'package:gym_app/views/Credential_Pages/Credential_Pages/signup_pageview/signup_page.dart';
import 'package:gym_app/views/MainPage/mainpage.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String email = '';
  String password = '';
  String? emailErrorMessage;
  String? passwordErrorMessage;
  String? errorMessage;
  bool isSignin = true;
  final _formkey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    void hideKeyboard() {
      FocusScope.of(context).unfocus();
    }

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: _height / 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              // SizedBox(height: _height / 9),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('email'),
                  decoration: TextDecor(
                      hintTexts: "Email", errorMsg: emailErrorMessage),
                  validator: (value) {
                    if (!(value.toString().contains(RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")))) {
                      return 'Invalid Email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _passwordVisible,
                  key: ValueKey('password'),
                  decoration: TextDecor(
                    hintTexts: "Password",
                    errorMsg: passwordErrorMessage,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye_fill,
                        color: Colors.blueGrey.shade500,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value.toString().length < 6) {
                      return 'Password is short';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value!;
                    });
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword(
                                    emailFromSignin: email,
                                  )));
                    },
                    child: Text(
                      "Forget your password?",
                      style: TextStyle(
                          color: Colors.indigo.shade400,
                          fontWeight: FontWeight.w400),
                    )),
              ),
              purpleBtn(
                btnName: "Login",
                onPressedBtn: () async {
                  hideKeyboard();
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    final signInStatus = await Auth().signIn(email, password);
                    if (signInStatus == AuthResultStatus.successful) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ));
                    } else if (signInStatus ==
                        AuthResultStatus.emailIsNotVerified) {
                      final snackBar = SnackBar(
                        content: const Text(
                          'Email is not verified yet, Resent the link?',
                        ),
                        action: SnackBarAction(
                          label: 'Resend Email',
                          onPressed: () {
                            Auth().verifyEmail();
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      String errorMsgSignin =
                          AuthExceptionHandler.generateExceptionMessage(
                              signInStatus);

                      errorMsg(errorMsgSignin);
                    }
                    // Navigator.push(
                    //     context, SmoothZoomRoute(page: PageviewForms()));
                  }
                },
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(text: "Don't have an account? "),
                      TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                              color: Colors.indigo.shade400,
                              fontWeight: FontWeight.w400),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ));
                            }),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "- OR -",
                  style: TextStyle(
                      color: Colors.blueGrey, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      // shape: MaterialStateProperty.all(OutlinedBorder(side: )),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.indigo.shade900,
                      ),
                    ),
                    onPressed: () async {
                      final status = await Auth().signInWithGoogle();

                      if (status.user != null) {
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ));
                      }
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.indigo.shade100,
                      size: 28,
                    ),
                    label: Center(
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void errorMsg(String errorMsgSignin) {
    switch (errorMsgSignin[0]) {
      case "p":
        setState(() {
          emailErrorMessage = null;
          passwordErrorMessage = errorMsgSignin.substring(1);
        });
        break;
      case "e":
        setState(() {
          passwordErrorMessage = null;
          emailErrorMessage = errorMsgSignin.substring(1);
        });
        break;

      default:
        setState(() {
          errorMessage = errorMsgSignin;
        });
    }
  }
}
