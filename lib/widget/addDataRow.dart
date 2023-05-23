import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDataRow extends StatelessWidget {
   AddDataRow({required this.function ,required this.text,this.btnColor=Colors.white,
     this.iconColor=Colors.black45}) ;
 var function;
 var text;
 late Color btnColor;
 late Color iconColor;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
          text,
          style:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Spacer(),
        ElevatedButton(
          onPressed:function,
          child: Icon(
            Icons.add,
            color: iconColor,
          ),
          style: ButtonStyle(
            minimumSize:
            MaterialStateProperty.all<Size>(Size(50, 25)),
            backgroundColor:
            MaterialStateProperty.all<Color>(btnColor),
          ),
        ),

      ],
    );

  }
}
