import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/compnents/conversation_list.dart';
import 'package:zego_zimkit/pages/message_list_page.dart';
import 'package:zego_zimkit/services/services.dart';
import 'package:zego_zimkit/utils/dialogs_utils.dart';

import '../../SizeCalc.dart';
import '../../widget/ChatbubleWidget.dart';
import '../../widget/chatAppBar.dart';
import '../../widget/chatConversationWidget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ZIMKit().showDefaultNewPeerChatDialog(context);
          },
          child: Icon(Icons.add),
        ),
        body: ZIMKitConversationListView(
          itemBuilder: (context, conversation, defaultWidget) {
            int? timestamp = conversation.lastMessage?.info.timestamp;
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getHeight(context, 5),
                  horizontal: getWidth(context, 10)),
              child: Center(
                child: InkWell(
                  splashColor: Colors.blue,
                  child: ChatConversationWidget(conversation:conversation,timestamp:timestamp),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ZIMKitMessageListPage(
                          conversationID: conversation.id,
                          conversationType: conversation.type,
                          appBarBuilder: (context, defaultAppBar) {
                            return ChatAppBar(conversation: conversation,context: context );
                          },
                          showPickFileButton:false ,
                          showPickMediaButton: false,
                          messageItemBuilder:(context, message, defaultWidget) {
                            int ismine(){
                              return message.isMine?0:1;
                            }
                            var icon;
                            ("${message.info.sentStatus.name}"=="success")?
                            icon=Icons.check_circle_sharp: icon=Icons.check;

                            return Theme(
                              data: ThemeData(primaryColor: Colors.blue),
                              child:Chatwidget("${message.textContent?.text}"
                                  ,ismine()
                                  ,message,
                                  message.info.timestamp,
                                  icon
                              ),
                            );
                          } ,
                        );
                      },
                    ));
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text(
                              'Do you want to delete this conversation?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                ZIMKit().deleteConversation(
                                    conversation.id, conversation.type);

                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ));
  }

}