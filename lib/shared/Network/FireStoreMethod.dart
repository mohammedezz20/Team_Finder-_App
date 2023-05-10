
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../moadels/UserModel.dart';

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
}
