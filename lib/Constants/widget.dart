import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget purpleBtn({required String btnName, void Function()? onPressedBtn}) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          // shape: MaterialStateProperty.all(OutlinedBorder(side: )),
          backgroundColor: MaterialStateProperty.all(
            Colors.indigo.shade400,
          ),
          alignment: Alignment.center),
      onPressed: onPressedBtn,
      child: Text(
        btnName,
        style: TextStyle(
            color: Colors.grey.shade200,
            fontFamily: "ReadexPro",
            fontSize: 20,
            fontWeight: FontWeight.w400),
      ),
    ),
  );
}

PreferredSizeWidget backButtonAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: FaIcon(
        FontAwesomeIcons.arrowLeft,
        color: Colors.indigo.shade600,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

Widget pageTitle(String title) {
  return Container(
      margin: const EdgeInsets.all(15.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
      ));
}

Widget pageDescription(String description) {
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        description,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
      ));
}
