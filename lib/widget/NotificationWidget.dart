import 'package:advanced_project/shared/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Button.dart';
import '../SizeCalc.dart';

class NotificationWidget extends StatelessWidget {
  bool isRequest ;

  String userName ;
  String teamName ;

  NotificationWidget({
    required this.userName,
    required this.teamName,
    required this.isRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      height: getHeight(context, 80),
      width:double.infinity,
      child: Row(
        children: [
          //***********************************image**************************
          Container(
            width: getWidth(context, 46),
            height: getHeight(context, 46),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: CircleAvatar(
              radius: 22.5,
              backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/OIP.g9JQBsgn1JtJ4WirA1--IQHaHa?pid=ImgDet&rs=1'),
            ),
          ),
          //*******************************Separator********************************
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 2,
              height: getHeight(context, 50),
              color: Colors.grey,
            ),
          ),
          //*******************************body********************************
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isRequest) ...[
                  Container(
                    width: getWidth(
                        context,
                        MediaQuery.of(context).size.width -
                            getWidth(context,60)),
                    child: RichText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(

                        text: userName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children:  <TextSpan>[
                           TextSpan(
                            text: ' sent you a request to join your team ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: teamName,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(context, 3),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      NotificatioOption(
                          function: () {  },
                        Fsize: 8,
                          text: 'Show Profile',
                        isupper: false,
                        background: buttonColor,
                        radius: 3,
                      height: getHeight(context, 20),
                        width: getWidth(context, 80),
                      ),
                      SizedBox(width: getWidth(context, 3),),
                      NotificatioOption(
                          function: () {  },
                        Fsize: 8,
                          text: 'Accept',
                        isupper: false,
                        background: buttonColor,
                        radius: 3,
                      height: getHeight(context, 20),
                        width: getWidth(context, 50),
                      ),
                      SizedBox(width: getWidth(context, 3),),
                      NotificatioOption(
                          function: () {  },
                        Fsize: 8,
                          text: 'Excuse',
                        isupper: false,
                        background: buttonColor,
                        radius: 3,
                      height: getHeight(context, 20),
                        width: getWidth(context, 50),
                      ),
                    ],
                  ),
                ],
                if (!isRequest) ...[
                  Container(
                    width: getWidth(
                        context,
                        MediaQuery.of(context).size.width -
                            getWidth(context, 100)),
                    child: RichText(
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: userName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: ' accept your request to join ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: teamName,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
