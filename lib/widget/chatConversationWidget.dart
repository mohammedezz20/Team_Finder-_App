import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../SizeCalc.dart';

class ChatConversationWidget extends StatelessWidget {
  var conversation;
var timestamp;
   ChatConversationWidget({required this.conversation,required this.timestamp});


  String formatTimestamp(int? timestamp) {
    if (timestamp == null) {
      return 'null';
    }

    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (isSameDay(dateTime, now)) {
      String formattedTime = DateFormat('h:mm a').format(dateTime);
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
    return Ink(
      child: Row(
        children: [
          CircleAvatar(
            radius: getHeight(context, 30),
            backgroundImage: NetworkImage(conversation.avatarUrl),
          ),
          SizedBox(
            width: getWidth(context, 20),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      conversation.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Spacer(),
                    Text(
                      "${formatTimestamp(timestamp)}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                    Text(
                        "${conversation.unreadMessageCount}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      width: getWidth(context, 20),
                    )
                  ],
                ),
                Text(
                  "${conversation.lastMessage?.textContent?.text}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
