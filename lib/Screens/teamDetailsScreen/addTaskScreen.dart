import 'package:advanced_project/moadels/taskmodel.dart';
import 'package:advanced_project/widget/ShowSnakebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../SizeCalc.dart';
import '../../shared/cubit/teamCubit/teamState.dart';
import '../../shared/cubit/teamCubit/teamcubit.dart';
import '../../widget/Button.dart';
import '../../widget/teamTextFieldWidget .dart';
import '../../widget/timePickerWidget.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({this.newTask = true});


  AddTaskScreen.edit({this.newTask = false, required this.taskmodel});

  bool newTask;

  TaskModel taskmodel = TaskModel(taskTitle: '',
      taskDetails: '',
      startDate: Timestamp.now(),
      deadLine: Timestamp.now(),
      status: '');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit, TeamStates>(
        builder: (context, state) {


          var cubit = TeamCubit.get(context);

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
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
                  newTask ? "Add new task" : "Edit task",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    TeamTextFieldWidjet(
                      controller: cubit.taskTitleController,
                      text: "Task title...",
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: getHeight(context, 20),
                    ),
                    TeamTextFieldWidjet(
                      controller: cubit.taskDescriptionController,
                      text: "Task description...",
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: getHeight(context, 20),
                    ),
                    Divider(color: Colors.grey, thickness: 2),
                    Text(
                      "Start Time",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Divider(color: Colors.grey, thickness: 2),
                    TimePickerWidget(onTap: () {
                      cubit.selectDate(context, true);
                    },
                      mainText: "Date : ",
                      selectedTimeOrDate: "${cubit.startSelectedDate.toString()
                          .substring(0, 10)}",),
                    TimePickerWidget(onTap: () {
                      cubit.selectTime(context, true);
                    },
                      mainText: "Time : ",
                      selectedTimeOrDate: "${cubit.startSelectedTime.toString()
                          .substring(10, 15)}",),
                    Divider(color: Colors.grey, thickness: 2),
                    Text(
                      "Deadline",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Divider(color: Colors.grey, thickness: 2),
                    TimePickerWidget(onTap: () {
                      cubit.selectDate(context, false);
                    },
                      mainText: "Date : ",
                      selectedTimeOrDate: "${cubit.deadlineSelectedDate
                          .toString().substring(0, 10)}",),
                    TimePickerWidget(onTap: () {
                      cubit.selectTime(context, false);
                    },
                      mainText: "Time : ",
                      selectedTimeOrDate: "${cubit.deadlineSelectedTime
                          .toString().substring(10, 15)}",),
                    SizedBox(height: getHeight(context, 30),),
                    defaultButton(function: () {
                    if(newTask)  {
                            Timestamp statrtTime = cubit.convertTimeAndDateToTimeStamp(
                                "${cubit.startSelectedDate.toString().substring(0, 10)}",
                                "${cubit.startSelectedTime.toString().substring(10, 15)}");
                            Timestamp deadline = cubit.convertTimeAndDateToTimeStamp(
                                "${cubit.deadlineSelectedDate.toString().substring(0, 10)}",
                                "${cubit.deadlineSelectedTime.toString().substring(10, 15)}");
                            DateTime firstDateTime = statrtTime.toDate();
                            DateTime secondDateTime = deadline.toDate();
                            if (cubit.taskTitleController.text == '') {
                              ShowSnackBar(
                                  context: context,
                                  text: "The task title must not be empty.");
                            } else if (secondDateTime.isBefore(firstDateTime) ||
                                secondDateTime
                                    .isAtSameMomentAs(firstDateTime)) {
                              ShowSnackBar(
                                  context: context,
                                  text:
                                      "The deadline cannot be before or equal the task starts time.");
                            } else {
                              ShowSnackBar(
                                  context: context,
                                  text: "Task added successfully.");
                              cubit.addnewTask(cubit.currentTeam?.teamID);
                              Navigator.pop(context);
                            }
                          }
                    else{
                      Timestamp statrtTime = cubit.convertTimeAndDateToTimeStamp(
                          "${cubit.startSelectedDate.toString().substring(0, 10)}",
                          "${cubit.startSelectedTime.toString().substring(10, 15)}");
                      Timestamp deadline = cubit.convertTimeAndDateToTimeStamp(
                          "${cubit.deadlineSelectedDate.toString().substring(0, 10)}",
                          "${cubit.deadlineSelectedTime.toString().substring(10, 15)}");
                      DateTime firstDateTime = statrtTime.toDate();
                      DateTime secondDateTime = deadline.toDate();
                      if (cubit.taskTitleController.text == '') {
                        ShowSnackBar(
                            context: context,
                            text: "The task title must not be empty.");
                      } else if (secondDateTime.isBefore(firstDateTime) ||
                          secondDateTime
                              .isAtSameMomentAs(firstDateTime)) {
                        ShowSnackBar(
                            context: context,
                            text:
                            "The deadline cannot be before or equal the task starts time.");
                      } else {
                        ShowSnackBar(
                            context: context,
                            text: "Task updated successfully.");
                        cubit.editTask(teamId:cubit.currentTeam?.teamID,tasId: taskmodel.taskID, status: taskmodel.status);
                        Navigator.pop(context);
                        Navigator.pop(context);

                      }
                    }
                        },
                        text: newTask ? 'Add task' : 'Edit task',
                        isupper: false,
                        radius: 10),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

}
