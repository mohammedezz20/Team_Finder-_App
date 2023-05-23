import 'package:advanced_project/SizeCalc.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Button.dart';
import 'ShowSnakebar.dart';
import 'teamTextFieldWidget .dart';

class AddNewSkillDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit, TeamStates>(
        builder: (context, state) {
          var cubit = TeamCubit.get(context);
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TeamTextFieldWidjet(
                    controller: cubit.teamRequiredSkillsController,
                    text: "Skill...",
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: getHeight(context, 20),
                  ),
                  defaultButton(
                      height: getHeight(context, 40),
                      radius: 5,
                      function: () {
                        if (cubit.teamRequiredSkillsController.text == '') {
                          Navigator.pop(context);
                        }
                        else{
                          cubit.addSkill(
                            cubit.teamRequiredSkillsController.text,
                          );
                          cubit.teamRequiredSkillsController.clear();
                          cubit.ShowSkillsWidget();
                          Navigator.pop(context);
                        }
                      },
                      text: 'Add Skill',
                      isupper: false),
                ],
              ),
            ),
          );
        },
        listener: (contect, state) {});
  }
}
