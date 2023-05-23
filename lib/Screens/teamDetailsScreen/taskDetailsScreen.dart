import 'package:advanced_project/Screens/teamDetailsScreen/addTaskScreen.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../SizeCalc.dart';
import '../../moadels/taskmodel.dart';
import '../../widget/Button.dart';
import '../../widget/taskDeatailsRowWidget.dart';

class TaskDeatailsScreen extends StatelessWidget {
  TaskDeatailsScreen({required this.task});
  TaskModel task;

  StringgetFormattedDate(timestamp) {
    String dateString =
        DateFormat('MMM dd, yyyy').format(timestamp.toDate()).toString();
    return dateString;
  }

  String convertTimestampTo12HourFormat(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit, TeamStates>(
        builder: (context, state) {
          var cubit = TeamCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0.0),
                child: Container(
                  width: getWidth(context, 370),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color(0xffBAE6FF),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                "Task Deatils",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getHeight(context, 15),
                  horizontal: getWidth(context, 20)),
              child: Column(
                children: [
                  TaskDeatailsRowWidget(
                    mainText: "Task title",
                    data: "${task.taskTitle}",
                  ),
                  Divider(color: Colors.grey, thickness: 2),
                  TaskDeatailsRowWidget(
                    mainText: "Description",
                    data: "${task.taskDetails}",
                  ),
                  Divider(color: Colors.grey, thickness: 2),
                  TaskDeatailsRowWidget(
                    mainText: "Start date",
                    data: "${StringgetFormattedDate(task.startDate)}",
                  ),
                  TaskDeatailsRowWidget(
                    mainText: "Start time",
                    data: "${convertTimestampTo12HourFormat(task.startDate)}",
                  ),
                  Divider(color: Colors.grey, thickness: 2),
                  TaskDeatailsRowWidget(
                    mainText: "DeadLine",
                    data: "${StringgetFormattedDate(task.deadLine)}",
                  ),
                  TaskDeatailsRowWidget(
                    mainText: "Time",
                    data: "${convertTimestampTo12HourFormat(task.deadLine)}",
                  ),
                  Divider(color: Colors.grey, thickness: 2),
                  TaskDeatailsRowWidget(
                    mainText: "Status",
                    data: task.status,
                  ),
                  Divider(color: Colors.grey, thickness: 2),
                  SizedBox(
                    height: getHeight(context, 20),
                  ),
                  if (cubit.userrole == 'admin' ||
                      cubit.userrole == 'owner') ...[
                    defaultButton(
                        function: () {
                          cubit.taskTitleController.text = task.taskTitle;
                          cubit.taskDescriptionController.text =
                              task.taskDetails;
                          DateTime Start = task.startDate.toDate();
                          DateTime end = task.deadLine.toDate();
                          cubit.startSelectedDate = Start;
                          cubit.startSelectedTime =
                              TimeOfDay.fromDateTime(Start);
                          cubit.deadlineSelectedDate = end;
                          cubit.deadlineSelectedTime =
                              TimeOfDay.fromDateTime(end);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AddTaskScreen.edit(taskmodel: task);
                          }));
                        },
                        text: 'Edit',
                        background: Colors.blue,
                        height: getHeight(context, 50),
                        radius: 10,
                        isupper: false),
                    SizedBox(
                      height: getHeight(context, 20),
                    ),
                    defaultButton(
                        function: () {
                          cubit.deleteTask(
                              teamId: cubit.currentTeam?.teamID,
                              taskId: task.taskID);
                          Navigator.pop(context);
                        },
                        text: 'Delete',
                        background: Colors.red,
                        height: getHeight(context, 50),
                        radius: 10,
                        isupper: false),
                    SizedBox(
                      height: getHeight(context, 20),
                    ),
                    if(task.status=='todo')...[        defaultButton(
                        function: () {
                          cubit.updateStatus(
                              teamId: cubit.currentTeam?.teamID,
                              taskId: task.taskID,
                              status: "ongoing");
                          Navigator.pop(context);
                        },
                        text: 'To Ongoing',
                        background: Colors.amber.shade300,
                        height: getHeight(context, 50),
                        radius: 10,
                        isupper: false,
                        ),],

                           if(task.status=='ongoing')...[
                             defaultButton(
                                 function: () {
                                   cubit.updateStatus(
                                       teamId: cubit.currentTeam?.teamID,
                                       taskId: task.taskID,
                                       status: "done");
                                   Navigator.pop(context);
                                 },
                                 text: 'To Done',
                                 background: Colors.green.shade400,
                                 height: getHeight(context, 50),
                                 radius: 10,
                                 isupper: false,
                             ),
                           ]
                  ]
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
