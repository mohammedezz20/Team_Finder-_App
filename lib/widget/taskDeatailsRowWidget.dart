import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../SizeCalc.dart';

class DeatailsRowWidget extends StatelessWidget {
   DeatailsRowWidget({required this.mainText,required this.data}) ;
var mainText;
var data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getHeight(context, 5)),
      child: Row(
        children: [
          Container(
           
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
           
            child: Expanded(
              child: Text(
                data,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),


              ),
            ),
          ),
        ],
      ),
    );
  }
}
