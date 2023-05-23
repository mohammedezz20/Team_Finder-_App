import 'dart:ffi';

import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:advanced_project/widget/skillWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequiredSkillsWidjet extends StatelessWidget {
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
                children:List.generate(cubit.skillsWidget.length,
                        (index) =>
                  SkillWidget(text:cubit.skillsWidget[index])
                ) ,
              ),
            ),
          );
        },
        listener: (context,state){});
  }
}
