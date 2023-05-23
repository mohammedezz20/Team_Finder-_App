
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../moadels/TeamModel.dart';
import '../../../moadels/UserModel.dart';
import '../../../moadels/membersmodel.dart';
import '../../../moadels/taskmodel.dart';

class FireStoreMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  addNewUser(
      {required String email,
      required String name,
      required String username,
      required String githubLink,
      required String linkedinLink,
      required photoURL,
      required Future<String> CV_URL,
      required User? user}) async {
    String cvUrl = await CV_URL;

    try {
      _firebaseFireStore.collection('users').doc(user!.uid).set({
        "username": username,
        "name": name,
        "email": email,
        "githubLink": githubLink,
        "linkedinLink": linkedinLink,
        "photoURL": photoURL,
        "cv_URL": cvUrl,
      });
    } catch (error) {
      return error.toString();
    }
  }

 Future<UserModel> getUserData(String userId) async {
    UserModel usermodel;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    usermodel=UserModel.fromMap(data);
    return usermodel;
  }

  void addTeamToFirestore( teamJson) async {


    CollectionReference teamsCollection = _firebaseFireStore.collection('teams');
    DocumentReference teamDoc = await teamsCollection.add(teamJson);

    print('Team added to Firestore with ID: ${teamDoc.id}');
  }

  Future<List<TeamModel>> getTeamsForUser(String userId) async {
    print(userId);
    QuerySnapshot querySnapshot = await _firebaseFireStore
        .collection('teams')
        .get();

    List<TeamModel> teams = [];
    var ismember;
    querySnapshot.docs.forEach((doc) {
      ismember=false;
       TeamModel team=TeamModel.fromJson(doc.data() as Map<String, dynamic>);
       team.teamID=doc.id;
       for (Member member in team.members) {
         if (member.uid == userId) {
           ismember = true;
         }
       }
       if(ismember)
         {
          teams.add(team);
         }
    });
    return teams;
  }

  Future<void> addTaskToFirestore(String teamId, TaskModel task) async {

    final CollectionReference tasksCollection = _firebaseFireStore.collection('teams').
    doc(teamId).collection('tasks');

    DocumentReference taskDoc=await tasksCollection.add({
      'taskTitle': task.taskTitle,
      'taskDetails': task.taskDetails,
      'startDate': task.startDate,
      'deadLine': task.deadLine,
      'status': task.status,
    });
    print('Task added to Firestore with ID: ${taskDoc.id}');
  }
  Future<List<TaskModel>> getAllTasksByTeamId(String teamId) async {

    QuerySnapshot  querySnapshot = await _firebaseFireStore.collection('teams').doc(teamId).collection('tasks').get();

    List<TaskModel> allTasks = [];
   querySnapshot.docs.forEach((doc) {
     TaskModel taskSample=TaskModel.fromJson(doc.data() as Map<String,dynamic>);
     taskSample.taskID=doc.id;
     print(taskSample.taskID);
     allTasks.add(taskSample);
   });
    return allTasks;
  }

  Future<void> updateTask({
    required String documentId,
    required String teamId,
    required TaskModel UpdatedTask
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference<Map<String, dynamic>> documentRef =
    firestore.collection('teams').doc(teamId).collection('tasks').doc(documentId);

    Map<String, dynamic> updatedData = {
      'taskTitle': UpdatedTask.taskTitle,
      'taskDetails': UpdatedTask.taskDetails,
      'startDate': UpdatedTask.startDate,
      'deadline': UpdatedTask.status,
      'status': UpdatedTask.status,
    };

    await documentRef.update(updatedData);
    print('Document updated successfully!');

  }
  Future<void> updateTaskStatus({
    required String documentId,
    required String teamId,
    required String newStatus
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference<Map<String, dynamic>> documentRef =
    firestore.collection('teams').doc(teamId).collection('tasks').doc(documentId);

    await documentRef.update({'status': newStatus});
    print('Document updated successfully!');

  }

  Future<void> deleteTask({required teamId,
  required taskID}) async {
    await _firebaseFireStore.collection('teams').doc(teamId).collection('tasks')
        .doc(taskID)
        .delete();

  }


}
