import 'package:flutter/material.dart';

class TextDecor extends InputDecoration {
  final String hintTexts;
  String? errorMsg;

  TextDecor({required this.hintTexts, this.errorMsg, Widget? suffixIcon})
      : super(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.blueGrey.shade100,

          hintText: hintTexts,
          errorStyle: const TextStyle(
              fontFamily: "ReadexPro", fontWeight: FontWeight.w400),
          hintStyle: const TextStyle(
              fontFamily: "ReadexPro", fontWeight: FontWeight.w400),
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 2.7),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.7),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.7),
          ),
          errorText: errorMsg,
        );
}
