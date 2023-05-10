

import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.lightBlue,
  Color fontcolor = Colors.white,
  required VoidCallback function,
  required String text,
  bool isupper = true,
  double radius = 0.0,
  double? height,
  double Fsize = 18,
}) =>
    Container(
      height:height ,
      width: width,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
          onPressed: function,
          child: Text(
            (isupper ? text.toUpperCase() : text),
            style: TextStyle(color: fontcolor, fontSize: Fsize),
          )),
    );





Widget NotificatioOption({
  double width = double.infinity,
  Color background = Colors.lightBlue,
  Color fontcolor = Colors.white,
  required VoidCallback function,
  required String text,
  bool isupper = true,
  double radius = 0.0,
  double? height,
  double Fsize = 18,
}) =>
    Container(
      alignment: Alignment.center,
      height:height ,
      width: width,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
      child: InkWell(
          onTap: function,
          splashColor: Colors.grey,
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                (isupper ? text.toUpperCase() : text),
                style: TextStyle(color: fontcolor, fontSize: Fsize),
              ),
            ),
          )),
    );