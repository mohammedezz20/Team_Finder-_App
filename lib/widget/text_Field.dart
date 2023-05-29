import 'package:advanced_project/SizeCalc.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  var controller = TextEditingController();
  var text;
  var suffixIcon;
  var suffixpressed;
  var ispass;
  var maxline;
  var hint;
  var h;

  DefaultTextField(
      {super.key, required this.controller,
      required this.text,
       this.suffixIcon,
       this.suffixpressed,
      required this.ispass,
      required this.hint,
      this.maxline=1,this.h=45.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$text",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: getHeight(context, 5),),
        TextFormField(
        textAlignVertical: TextAlignVertical.center,
          obscureText: ispass,
          obscuringCharacter: '*',
          maxLines: maxline,
          controller: controller,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
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
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            hintText:hint,
            hintStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
