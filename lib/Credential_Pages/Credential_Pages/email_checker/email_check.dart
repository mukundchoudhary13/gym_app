import 'package:flutter/material.dart';
import 'package:gym_app/Constants/widget.dart';

class EmailCheck extends StatefulWidget {
  EmailCheck(
      {Key? key, required this.checkEmail, required this.fromresetPassword})
      : super(key: key);
  String checkEmail;
  bool fromresetPassword;

  @override
  _EmailCheckState createState() => _EmailCheckState();
}

class _EmailCheckState extends State<EmailCheck> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: backButtonAppbar(context),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Text(
                  "Check your Email",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              pageDescription(widget.fromresetPassword
                  ? "A link to reset your password has been sent."
                  : "A link to email verification has been sent."),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Center(
                  child: Text(
                    widget.checkEmail,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
              ),
              purpleBtn(
                btnName: "Back to Login",
                onPressedBtn: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          )),
    );
  }
}
