import 'package:advanced_project/moadels/TeamModel.dart';
import 'package:advanced_project/moadels/UserModel.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SizeCalc.dart';

class MemberWidget extends StatelessWidget {
   MemberWidget({Key? key,required this.user,required this.team}) : super(key: key);
UserModel user;
TeamModel team;
  @override
  Widget build(BuildContext context) {
    print(team.role);
    return BlocConsumer<TeamCubit,TeamStates>(builder: (context,state){
      return InkWell(
        child: Ink(
          child: Row(
            children: [
              CircleAvatar(
                radius: getHeight(context, 30),
                backgroundImage: NetworkImage(user.photoURL),
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
                   Column(
                     children: [
                       Text(
                         user.name,
                         style: TextStyle(
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                             color: Colors.black),
                       ),
                       Text(
                         user.username,
                         style: TextStyle(
                             fontSize: 12,
                             fontWeight: FontWeight.w400,
                             color: Colors.black54),
                       ),
                     ],
                   ),
                        Spacer(),
                        Text(
                         "${user.role}" ,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        SizedBox(width: getWidth(context, 20),)

                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }, listener: (context,state){});
  }
}
