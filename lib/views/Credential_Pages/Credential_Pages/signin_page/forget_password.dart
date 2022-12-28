import 'package:flutter/material.dart';
import 'package:gym_app/Constants/constant.dart';
import 'package:gym_app/Constants/widget.dart';
import 'package:gym_app/Services/Firebase/auth_exception.dart';
import 'package:gym_app/Services/Firebase/auth_functions.dart';

import '../email_checker/email_check.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key, this.emailFromSignin}) : super(key: key);
  String? emailFromSignin;

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String? errorMessage;
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
                  "Recover Password",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              pageDescription("Don't worry, happens to the best of us."),
              SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.emailFromSignin,
                  style: TextStyle(fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('email'),
                  decoration:
                      TextDecor(hintTexts: "Email", errorMsg: errorMessage),
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
              purpleBtn(
                  btnName: "Continue",
                  onPressedBtn: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      final status = await Auth().resetPassword(email);
                      if (status == AuthResultStatus.successful) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailCheck(
                                      checkEmail: email,
                                      fromresetPassword: true,
                                    )));
                      } else {
                        String errorMsg =
                            AuthExceptionHandler.generateExceptionMessage(
                                status);
                        setState(() {
                          errorMessage = errorMsg.substring(1);
                        });
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
