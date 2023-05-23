import 'package:advanced_project/SizeCalc.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widget/addDataRow.dart';
import '../../widget/teamTasksContainer.dart';
import 'addTaskScreen.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit, TeamStates>(
        builder: (context, state) {
          var cubit = TeamCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
body: (state is GetTaskLoadingState)?
const SpinKitSpinningLines(
  color: Colors.blue,
  size: 80,
  itemCount: 8,
  lineWidth: 3,
):
Flex(
  crossAxisAlignment: CrossAxisAlignment.start,
  direction: Axis.vertical,
  children: [
    !(cubit.userrole=='admin'||cubit.userrole=='owner')?
    Padding(
      padding:  EdgeInsets.symmetric(vertical: getHeight(context,8)),
      child: Text(
        "ToDO",
        style:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ):
    AddDataRow(function: (){
      Navigator.push(context, MaterialPageRoute(builder:(context)=>AddTaskScreen() ));
    }, text: "ToDo",),
    Flexible(
        flex:2,child: TeamTasksContainer(task:cubit.getToDo()),),
    Padding(
      padding:  EdgeInsets.symmetric(vertical: getHeight(context, 8)),
      child: Text(
        "Ongoing",
        style:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ),
    Flexible(flex:2,child: TeamTasksContainer(task:cubit.getOnGoing()),),
    Padding(
      padding:  EdgeInsets.symmetric(vertical: getHeight(context, 8)),
      child: Text(
        "Done",
        style:
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ),
    Flexible(flex:2,child: TeamTasksContainer(task:cubit.getDone()),),

  ],
),

          );
        },
        listener: (context, state) {});
  }
}
