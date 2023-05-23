import 'package:flutter/material.dart';

import '../SizeCalc.dart';
class UploadCV extends StatelessWidget {

  String logo;
  Color background;
  double height;
  double width;
  var function;
  var text;
  double radius;

  UploadCV(
      {super.key,
        required this.logo,
        required this.text,
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
          border: Border.all(color: const Color(0xff63A1F1),width: 3),
          color: background, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(

          padding: const EdgeInsets.all(6),
          onPressed: function,
          child: Row(

            children: [
              const Spacer(flex: 4,),
              Image.asset(logo,width: getHeight(context, 40),height: getHeight(context, 40),),
              const Spacer(flex: 1,),

              Text("$text"),
              const Spacer(flex: 4,),

            ],
          )

      ),
    );
  }


}
