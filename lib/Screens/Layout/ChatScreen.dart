import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/compnents/conversation_list.dart';
import 'package:zego_zimkit/pages/message_list_page.dart';
import 'package:zego_zimkit/services/services.dart';
import 'package:zego_zimkit/utils/dialogs_utils.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {  ZIMKit().showDefaultNewPeerChatDialog(context);},
        child: Icon(Icons.add),
      ),
body:    ZIMKitConversationListView(
  onPressed: (context, conversation, defaultAction) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ZIMKitMessageListPage(
          conversationID: conversation.id,
          conversationType: conversation.type,
        );
      },
    ));
  },
),
    );

  }
}
