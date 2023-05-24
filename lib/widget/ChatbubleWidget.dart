
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../shared/Colors.dart';
import 'chatTextWidget.dart';

class Chatwidget extends StatelessWidget {
  final message;
  final String msg;
  final int index;
 var icon;
  Chatwidget(this.msg, this.index, this.message,this.timestamp,this.icon);
var timestamp;


  String formatTimestamp(int? timestamp) {
    if (timestamp == null) {
      return 'null';
    }

    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (isSameDay(dateTime, now)) {
      String formattedTime = DateFormat('hh:mm').format(dateTime);
      return formattedTime;
    } else if (isYesterday(dateTime, now)) {
      return 'Yesterday';
    } else {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      return formattedDate;
    }
  }
  bool isSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  bool isYesterday(DateTime dateTime, DateTime now) {
    DateTime yesterday = now.subtract(Duration(days: 1));
    return isSameDay(dateTime, yesterday);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        index == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(

            constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width*.9, ),
            decoration: BoxDecoration(
              borderRadius: index == 1
                  ? BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(15))
                  : BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15)),
              color: index == 1 ? Color(0xffc5c5c5) : Color(0xff246BFD),
            ),
            // width: MediaQuery.of(context).size.width * .88,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: IntrinsicWidth(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index == 1) ...[

                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextWidget(
                                label: msg,
                                color: Colors.black,
                              ),
                              Text(formatTimestamp(timestamp)),

                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),

                    ],
                    if (index == 0) ...[

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            TextWidget(
                              label: msg,
                              color: Colors.white,

                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(formatTimestamp(timestamp),style:
                                TextStyle(color: Colors.white,fontSize: 12),),

                                Icon(icon,color: Colors.white,size: 12,)
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}