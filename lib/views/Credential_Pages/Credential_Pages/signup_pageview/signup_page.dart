import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/Constants/constant.dart';
import 'package:gym_app/Constants/widget.dart';
import 'package:gym_app/Services/Firebase/auth_exception.dart';
import 'package:gym_app/Services/Firebase/auth_functions.dart';

import '../email_checker/email_check.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String? emailErrorMessage;
  String? passwordErrorMessage;
  String? errorMessage;
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: backButtonAppbar(context),
        body: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
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
              purpleBtn(
                  btnName: "SignUp",
                  onPressedBtn: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      final status = await Auth().signUp(email, password);

                      if (status == AuthResultStatus.successful) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EmailCheck(
                                  checkEmail: email,
                                  fromresetPassword: false,
                                )));
                      } else {
                        String errorMsgSignin =
                            AuthExceptionHandler.generateExceptionMessage(
                                status);

                        switch (errorMsgSignin[0]) {
                          case "p":
                            setState(() {
                              emailErrorMessage = null;
                              passwordErrorMessage =
                                  errorMsgSignin.substring(1);
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}
