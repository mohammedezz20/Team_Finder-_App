import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../SizeCalc.dart';

class TaskDeatailsRowWidget extends StatelessWidget {
   TaskDeatailsRowWidget({required this.mainText,required this.data}) ;
var mainText;
var data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getHeight(context, 5)),
      child: Row(
        children: [
          Container(
            width: 1.7 * MediaQuery.of(context).size.width / 6,
            child: Text(
              mainText,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 18),
            ),
          ),
          Text(
            ": ",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
          ),
          Container(
            width: 3.5 * MediaQuery.of(context).size.width / 6,
            child: Text(
              data,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),


            ),
          ),
        ],
      ),
    );
  }
}
