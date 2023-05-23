import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../SizeCalc.dart';

class TimePickerWidget extends StatelessWidget {
   TimePickerWidget({Key? key,required this.onTap,
     required this.mainText,
     required this.selectedTimeOrDate}) : super(key: key);
var onTap;
var selectedTimeOrDate;
var mainText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getHeight(context, 10)),
      child: Row(
        children: [
          Text(
            mainText,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          Text(
            selectedTimeOrDate,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 20),
          ),
          Spacer(),
          InkWell(
            splashColor: Colors.grey,
            onTap: onTap,
            child: Ink(
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
