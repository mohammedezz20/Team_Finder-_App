import 'package:flutter/material.dart';



ShowSnackBar({context, text}){
  return  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
    content:  Center(
        child: Text(
          textAlign: TextAlign.center,
          "$text",
          style: const TextStyle(color: Colors.black),
        )),
    padding: const EdgeInsets.all(10),
    backgroundColor: Colors.grey,

  ));


}