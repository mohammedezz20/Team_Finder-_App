import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zimkit/compnents/conversation_list.dart';
import 'package:zego_zimkit/pages/message_list_page.dart';
import 'package:zego_zimkit/services/services.dart';
import 'package:zego_zimkit/utils/dialogs_utils.dart';

import '../../SizeCalc.dart';
import '../../shared/cubit/teamCubit/teamcubit.dart';
import '../../widget/ChatbubleWidget.dart';
import '../../widget/chatAppBar.dart';
import '../../widget/chatConversationWidget.dart';

class TeamChatScreen extends StatelessWidget {
  const TeamChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit, TeamStates>(
        builder: (context, state) {
          var cubit = TeamCubit.get(context);
          return Scaffold(
            body: ZIMKitMessageListPage(
                conversationID: cubit.currentTeam?.teamID,
                conversationType: ZIMConversationType.group,

                appBarBuilder: (context, defaultAppBar) {
                  return null;
                },
                showPickFileButton: false,
                showPickMediaButton: false,
                messageItemBuilder: (context, message, defaultWidget) {
                  int ismine() {
                    print(message.info.senderUserID);
                    return message.isMine ? 0 : 1;
                  }

                  var icon;
                  ("${message.info.sentStatus.name}" == "success")
                      ? icon = Icons.check_circle_sharp
                      : icon = Icons.check;

                  return Theme(
                    data: ThemeData(primaryColor: Colors.blue),
                    child: Chatwidget("${message.textContent?.text}", ismine(),
                        message, message.info.timestamp, icon),
                  );
                }),
          );
        },
        listener: (context, state) {});
  }
}
