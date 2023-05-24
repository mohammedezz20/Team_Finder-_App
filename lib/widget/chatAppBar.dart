
import 'package:flutter/material.dart';

AppBar? ChatAppBar({required conversation,required context}){
  return AppBar(
    backgroundColor: Color(0xffEEEEEE),
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        Spacer(),
        CircleAvatar(
          backgroundImage:
          NetworkImage(conversation.avatarUrl),
        ),

        const SizedBox(width: 15),

        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              conversation.name,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black),
              overflow: TextOverflow.clip,
            ),
            Text(conversation.id,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54),
                overflow: TextOverflow.clip)
          ],
        ),
        Spacer(flex: 10,),
      ],
    ),
  );
}