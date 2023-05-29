import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferance extends StatelessWidget {
  final String ConferanceId;
  final int appID =1905505406;
  final String appSign ='1897b74600c15783a741228409f0fb65d4c99f972cdc723617af100c81f36d4b';

  VideoConferance(this.ConferanceId);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit,TeamStates>(builder: (context,state){
      var cubit =TeamCubit.get(context);
      return BlocConsumer<AppCubit,AppStates>(builder: (context,state){
        final double statusBarHeight = MediaQuery.of(context).padding.top;

        var cubit =TeamCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Scaffold(
            body: Padding(
              padding:  EdgeInsets.only(top: statusBarHeight),
              child: ZegoUIKitPrebuiltVideoConference(


                appID: 1905505406, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
                appSign: '1897b74600c15783a741228409f0fb65d4c99f972cdc723617af100c81f36d4b', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
                userID: AppCubit.get(context).usermodel!.username,
                userName: AppCubit.get(context).usermodel!.name,
                conferenceID: cubit.currentTeam!.teamID,

                config: ZegoUIKitPrebuiltVideoConferenceConfig(
                  turnOnCameraWhenJoining: false,
                  turnOnMicrophoneWhenJoining:false,
                  useSpeakerWhenJoining: true,
                  avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user, Map extraInfo) {
                    return user != null
                        ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            '${AppCubit.get(context).usermodel!.photoURL}',
                          ),
                          fit: BoxFit.cover
                        ),
                      ),
                    )
                        : const SizedBox();
                  },
                ),
              ),
            ),

          ),
        );
      }, listener: (context,state){});
    }, listener: (context,state){});
  }
}