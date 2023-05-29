import 'dart:io';

import 'package:advanced_project/main.dart';
import 'package:advanced_project/moadels/TeamModel.dart';
import 'package:advanced_project/shared/Network/remote/FirebaseStorageMethod.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zego_zimkit/services/defines.dart';

import '../../../Screens/teamDetailsScreen/TeamChatScreen.dart';
import '../../../Screens/teamDetailsScreen/dashboard.dart';
import '../../../Screens/teamDetailsScreen/requestScreen.dart';
import '../../../moadels/UserModel.dart';
import '../../../moadels/membersmodel.dart';
import '../../../moadels/taskmodel.dart';
import '../../../widget/skillWidget.dart';
import '../../Network/remote/FireStoreMethod.dart';
import '../../Network/remote/auth_method.dart';

class TeamCubit extends Cubit<TeamStates> {
  TeamCubit() : super(TeamInitialState());

  static TeamCubit get(context) => BlocProvider.of(context);

  var Screens = <Widget>[
    DashboardScreen(),
    TeamNotificationScreen(),
    TeamChatScreen(),
  ];

  //*****************************show and hide call button****************
  var ischatScreen = false;
  showVideoCallButton() {
    ischatScreen = !ischatScreen;
    emit(TeamshowVideoCallButtonState());
  }

  hideVideoCallButton() {
    ischatScreen = false;
    emit(TeamhideVideoCallButtonState());
  }
//*****************************Pick team Logo****************

  bool useImage = false;
  usingimagestate() {
    useImage = !useImage;
    emit(TeamUsingimageState());
  }

  XFile imageFile = XFile("");
  File? file;
  Future<void> imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":
        imageFile = (await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 90,
        ))!;
        break;
      case "camera":
        imageFile = (await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 90,
        ))!;
        break;
    }

    if (imageFile != null) {
      file = File(imageFile.path);
      print("You selected image : ${imageFile.path}");
      emit(TeampickImageSuccessState());
    } else {
      print("You have not taken an image");
      emit(TeampickImagefaildState("You have not taken an image"));
    }

    Navigator.pop(context);
  }

  //*****************************Category List****************
  final List<String> category = [
    'Mobile Development',
    'Desktop Development',
    'Web Development',
    'Web Design',
    'Project Management',
    'Graphic Design',
    'Marketing',
    'Writing',
    'Video Editing',
    'UI/UX Design',
    'Database Administration',
    'Quality Assurance (QA)',
    'DevOps',
    'Artificial Intelligence (AI)',
    'Cybersecurity',
    'Front-end Development',
    'Back-end Development',
    'Game Development',
    'Cloud Computing',
    'other'
  ];
  var selectedValue;
  SelectValue(value) {
    selectedValue = value;
    getTeamsByCategory();
    emit(SelectValueState());
  }

//*****************************controllers****************
  var teamNameController = TextEditingController();
  var teamDescriptionController = TextEditingController();
  var teamRequiredSkillsController = TextEditingController();
  var teamDropDownListController = TextEditingController();

//*****************************Skills List****************
  var skillShow = false;
  List<String> skillsWidget = [];

  void addSkill(String text) {
    skillsWidget.add(text);
    emit(AddNewSkillsState());
  }

  void removeSkill(String text) {
    skillsWidget.remove(text);
    emit(RemoveSkillsState());
  }

  void ShowSkillsWidget() {
    skillShow = true;
    emit(ShowSkillsWidgetState());
  }

  void HideSkillsWidget() {
    skillShow = false;
    emit(HideSkillsWidgetState());
  }

  //*************************Add New Team ***************
  Auth auth = Auth();
  FireStoreMethod fireStoreMethod = FireStoreMethod();
  FirebaseStorageMethod firebaseStorageMethod = FirebaseStorageMethod();
  UserModel? usermodel;

  Future<void> loadUserData() async {
    UserModel userData = await fireStoreMethod.getUserData(auth.user!.uid);
    usermodel = userData;
    emit(teamLoadUserDataStates());
  }

  addNewTeam() async {
    emit(AddTeamDataLoadingStates());
    try {
      var photoURL;
      if (file?.path == null) {
        photoURL = '';
      } else {
        photoURL = await firebaseStorageMethod.uploadImageToFirebase(file);
      }
      var team = await TeamModel(
        teamName: teamNameController.text,
        teamDescription: teamDescriptionController.text,
        teamCategory: selectedValue,
        requiredSkills: skillsWidget,
        logoURL: photoURL,
        creationDate: DateTime.now().toString(),
        members: [
          Member(uid: auth.user!.uid, role: "owner"),
        ],
      );

      fireStoreMethod.addTeamToFirestore(team.toJson());
      teamDescriptionController.clear();
      teamNameController.clear();
      skillsWidget.clear();
      HideSkillsWidget();
      imageFile = XFile('');
      getTeamsData();
    } catch (error) {
      emit(AddTeamDataFailStates(error.toString()));
    }
  }

  List<TeamModel> teamsList = [];
  getTeamsData() async {
    emit(GetTeamDataLoadingStates());
    try {
      teamsList = await fireStoreMethod
          .getTeamsForUser(auth.user!.uid)
          .whenComplete(() {
        emit(GetTeamDataSuccessStates());
      });
    } catch (error) {
      print(error.toString());
      emit(GetTeamDataFailStates(error.toString()));
    }
  }

  var userrole;
  userRole(List<Member> members) {
    for (var member in members) {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      print(member.uid);
      print(member.role);
      if (member.uid == auth.user!.uid) {
        print("ssssssssssssssssssssssssssssssssssssssssssss");
        userrole = member.role;
      }
    }
  }

//*******************************Task***************************
  List<TaskModel> taskList = [];
  List<TaskModel> getToDo() {
    List<TaskModel> todo = [];
    for (var task in taskList) {
      if (task.status == 'todo') {
        todo.add(task);
      }
    }
    return todo;
  }

  List<TaskModel> getOnGoing() {
    List<TaskModel> ongoing = [];
    for (var task in taskList) {
      if (task.status == 'ongoing') {
        ongoing.add(task);
      }
    }
    return ongoing;
  }

  List<TaskModel> getDone() {
    List<TaskModel> done = [];
    for (var task in taskList) {
      if (task.status == 'done') {
        done.add(task);
      }
    }
    return done;
  }

//************************AddTask**************************
  TeamModel? currentTeam;
  var taskTitleController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  DateTime startSelectedDate = DateTime.now();
  DateTime deadlineSelectedDate = DateTime.now();
  TimeOfDay startSelectedTime =
      TimeOfDay(hour: DateTime.now().hour + 1, minute: 0);
  TimeOfDay deadlineSelectedTime =
      TimeOfDay(hour: DateTime.now().hour + 1, minute: 0);
  Future<void> selectDate(BuildContext context, bool isstart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isstart) {
        startSelectedDate = picked;
        // print("1111111111111111111111111111111111111111111111111111111111111");
        // print(startSelectedDate);
      } else {
        deadlineSelectedDate = picked;
        // print("1111111111111111111111111111111111111111111111111111111111111");
        // print(dedlineSelectedDate);
      }
    }
    emit(selectDateState());
  }

  Future<void> selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: DateTime.now().hour + 1, minute: 0),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (picked != null) {
      if (isStart) {
        startSelectedTime = picked;
        // print("1111111111111111111111111111111111111111111111111111111111111");
        // print(startSelectedTime);
      } else {
        deadlineSelectedTime = picked;
        // print("1111111111111111111111111111111111111111111111111111111111111");
        // print(deadlineSelectedTime);
      }
    }
    emit(selectTimeState());
  }

  Timestamp convertTimeAndDateToTimeStamp(dateString, timeString) {
    List<String> dateParts = dateString.split('-');

    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    List<String> timeParts = timeString.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    DateTime dateTime = DateTime(year, month, day, hour, minute);
    Timestamp timestamp = Timestamp.fromDate(dateTime);
    return timestamp;
  }

  addnewTask(var teamId) {
    try {
      TaskModel newtask = TaskModel(
          taskTitle: taskTitleController.text,
          taskDetails: taskDescriptionController.text,
          startDate: convertTimeAndDateToTimeStamp(
              "${startSelectedDate.toString().substring(0, 10)}",
              "${startSelectedTime.toString().substring(10, 15)}"),
          deadLine: convertTimeAndDateToTimeStamp(
              "${deadlineSelectedDate.toString().substring(0, 10)}",
              "${deadlineSelectedTime.toString().substring(10, 15)}"),
          status: "todo");
      fireStoreMethod.addTaskToFirestore(teamId, newtask).whenComplete(() {
        emit(AddTaskSuccessState());
      });
    } catch (error) {
      emit(AddTaskSFaildState("Error when add task : " + error.toString()));
    }
    startSelectedDate = DateTime.now();
    deadlineSelectedDate = DateTime.now();
    startSelectedTime = TimeOfDay(hour: DateTime.now().hour + 1, minute: 0);
    deadlineSelectedTime = TimeOfDay(hour: DateTime.now().hour + 1, minute: 0);
    taskTitleController.clear();
    taskDescriptionController.clear();
    getTasks(currentTeam?.teamID);
  }

  getTasks(teamID) async {
    emit(GetTaskLoadingState());
    try {
      taskList = await fireStoreMethod.getAllTasksByTeamId(teamID);
      emit(GetTaskSuccessState());
    } catch (error) {
      emit(GetTaskSFaildState("Error when Get task : " + error.toString()));
    }
  }

  editTask({required teamId, required tasId, required status}) {
    try {
      TaskModel newtask = TaskModel(
          taskTitle: taskTitleController.text,
          taskDetails: taskDescriptionController.text,
          startDate: convertTimeAndDateToTimeStamp(
              "${startSelectedDate.toString().substring(0, 10)}",
              "${startSelectedTime.toString().substring(10, 15)}"),
          deadLine: convertTimeAndDateToTimeStamp(
              "${deadlineSelectedDate.toString().substring(0, 10)}",
              "${deadlineSelectedTime.toString().substring(10, 15)}"),
          status: status);
      fireStoreMethod.updateTask(
          documentId: tasId, teamId: teamId, UpdatedTask: newtask);
      emit(EditTaskSuccessState());
    } catch (error) {
      emit(EditTaskSFaildState(error.toString()));
    }
    startSelectedDate = DateTime.now();
    deadlineSelectedDate = DateTime.now();
    startSelectedTime = TimeOfDay(hour: DateTime.now().hour + 1, minute: 0);
    deadlineSelectedTime = TimeOfDay(hour: DateTime.now().hour + 1, minute: 0);
    taskTitleController.clear();
    taskDescriptionController.clear();
    getTasks(currentTeam?.teamID);
  }

  deleteTask({required teamId, required taskId}) async {
    try {
      await fireStoreMethod.deleteTask(teamId: teamId, taskID: taskId);
      emit(DeleteTaskSuccessState());
      getTasks(currentTeam?.teamID);
    } catch (error) {
      emit(DeleteTaskSFaildState(error.toString()));
    }
  }

  updateStatus({required teamId, required taskId, required status}) async {
    try {
      await fireStoreMethod.updateTaskStatus(
          documentId: taskId, teamId: teamId, newStatus: status);
      emit(UpdateStatusSuccessState());
      getTasks(currentTeam?.teamID);
    } catch (error) {
      emit(UpdateStatusFaildState(error.toString()));
    }
  }

//*****************************************seachteam********************************
  var searchTeamController = TextEditingController();
  List<TeamModel> teamSerchRes = [];
  getTeamsByCategory() async {
    emit(GetTeamsByCategoryLoadingState());
    try {
      teamSerchRes = await fireStoreMethod.getTeamswithCategory(
          auth.user!.uid, selectedValue);
      emit(GetTeamsByCategorySuccessState());
    } catch (error) {
      emit(GetTeamsByCategoryFaildState(error.toString()));
    }
  }

  List<UserModel> teamMemberData = [];
  getTeamMembersData(List<Member> members) async {
    emit(GetTeamMemberDataLoadingState());
    try {
      teamMemberData = await fireStoreMethod.getTeamsMemberData(members);
      emit(GetTeamMemberDataSuccessState());
    } catch (error) {
      emit(GetTeamMemberDataFaildState(error.toString()));
    }
  }
//*****************************************EditAndDataForTeam********************************
  create_room(){
    ZIMRoomInfo roomInfo = ZIMRoomInfo();
    roomInfo.roomID = currentTeam?.teamID;
    roomInfo.roomName = currentTeam!.teamName;
    ZIMRoomAdvancedConfig advancedConfig = ZIMRoomAdvancedConfig();

//Join a room directly.
    ZIM.getInstance()?.enterRoom(roomInfo, advancedConfig).then((value) => {
    print("teamroom joined")
    }).catchError((onError){
      print("teamroom not joined");

    });
  }

  var prevewtask=false;
var isEdit=false;
var isPreview=false;


}
