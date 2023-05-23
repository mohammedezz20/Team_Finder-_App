import 'package:advanced_project/Screens/teamDetailsScreen/taskDetailsScreen.dart';
import 'package:advanced_project/moadels/taskmodel.dart';
import 'package:advanced_project/widget/taskWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../moadels/TeamModel.dart';
import '../shared/cubit/teamCubit/teamState.dart';
import '../shared/cubit/teamCubit/teamcubit.dart';

class TeamTasksContainer extends StatelessWidget {
  TeamTasksContainer({Key? key, required this.task}) : super(key: key);
  List<TaskModel> task;
  @override
  Widget build(BuildContext context) {
    var cubit = TeamCubit.get(context);
    return BlocConsumer<TeamCubit, TeamStates>(
        builder: (context, state) {
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
              child: ListView.builder(

                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    TaskWidget(task: task[index],function: (){
                          Navigator.push(context, MaterialPageRoute(builder: 
                              (contest)=>TaskDeatailsScreen(task: task[index],)));
                    },),
                itemCount: task.length,
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
