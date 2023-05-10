import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  var controller = TextEditingController();
  var text;
  var suffixIcon;
  var suffixpressed;
  var ispass;
  var hint;

  DefaultTextField(
      {super.key, required this.controller,
      required this.text,
      required this.suffixIcon,
      required this.suffixpressed,
      required this.ispass,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(

          "$text",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 40,
          child: TextFormField(
            obscureText: ispass,
            obscuringCharacter: '*',
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


              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              hintText:hint,
              hintStyle: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
