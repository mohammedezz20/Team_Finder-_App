import 'package:advanced_project/moadels/TeamModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/teamCubit/teamState.dart';
import '../shared/cubit/teamCubit/teamcubit.dart';
import 'MemberWidget.dart';

class MembersContainer extends StatelessWidget {
   MembersContainer({required this.teamModel}) ;
TeamModel teamModel;
  @override
  Widget build(BuildContext context) {
    var cubit=TeamCubit.get(context);
    return BlocConsumer<TeamCubit,TeamStates>(builder:
        (context,state){
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xff000000),
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Wrap(
            children:List.generate(cubit.teamMemberData.length,
                    (index) {
              print(cubit.teamMemberData.length);
                      return MemberWidget(user: cubit.teamMemberData[index], team: teamModel,);
                    },
            ) ,
          ),
        ),
      );
    },
        listener: (context,state){});
  }
}
