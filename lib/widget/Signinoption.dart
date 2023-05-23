import 'package:flutter/material.dart';

import '../SizeCalc.dart';


class SigninOption extends StatelessWidget {

String logo;
Color background;
double height;
double width;
var function;

double radius;

SigninOption(
      {super.key, 
        required this.logo,

      required this.background,
     required  this.height,
      required this.width,
      required this.function,
      required this.radius});

  @override
  Widget build(BuildContext context) {


    return  Container(
      height:height ,
      width: width,

      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(

     padding: const EdgeInsets.all(6),
          onPressed: function,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(logo,width:getHeight(context, 40),height: getHeight(context, 40),),
              const Text("Continue With Google",style: TextStyle(fontSize: 20,color: Colors.white),),
            ],
          )

      ),
    );
  }


}

