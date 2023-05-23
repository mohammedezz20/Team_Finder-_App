import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamTextFieldWidjet extends StatelessWidget {

var controller ;

TeamTextFieldWidjet({
  required this.controller,
  required this.text,
  required this.maxLines
});

  var text;
var maxLines;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      cursorColor: Colors.grey,
      maxLines: maxLines,
      decoration: InputDecoration(

        contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        hintText: text,
        filled: true,
        fillColor: Color(0xffFFFFFF),
        focusedBorder: OutlineInputBorder(
          borderRadius:BorderRadius.circular(5) ,
          borderSide: BorderSide(color: Colors.black,width: 2),

        ),

        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(5) ,
          borderSide: BorderSide(color: Colors.black,width: 2),
        ),
      ),
    );
  }
}
