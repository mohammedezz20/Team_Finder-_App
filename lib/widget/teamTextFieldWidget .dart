import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamTextFieldWidjet extends StatelessWidget {
  var controller;

  TeamTextFieldWidjet(
      {required this.controller,
      required this.text,
      required this.maxLines,
      this.suffixIcon = null,
      this.prefixIcon = null,
      this.suffixpressed = null,
      this.prefixpressed = null});

  var text;
  var maxLines;
  var suffixIcon;
  var prefixIcon;
  var suffixpressed;
  var prefixpressed;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.grey,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  suffixpressed!();
                },
                icon: Icon(suffixIcon),
                color: Colors.grey,
              )
            : null,
        prefixIcon: prefixIcon != null
            ? IconButton(
                onPressed: () {
                  prefixpressed!();
                },
                icon: Icon(
                  prefixIcon,
                  color: Colors.grey,
                ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        hintText: text,
        filled: true,
        fillColor: Color(0xffFFFFFF),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
