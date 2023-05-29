import 'package:advanced_project/moadels/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../widget/ShowSnakebar.dart';
import 'FireStoreMethod.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  FireStoreMethod fireStoreMethod = FireStoreMethod();
  Stream<User?> get authChanges => _firebaseAuth.authStateChanges();
  User? get user => _firebaseAuth.currentUser;

  late Map<String, dynamic> currentUser = {};
  Sign_in_with_google({
    required String bio,
    required String about,
    required List<Map<String,dynamic>> links,
      required BuildContext context,
      required bool isnew}) async {
    try {
      GoogleSignInAccount? googlesignin = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth =
          await googlesignin?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser && isnew) {
          await fireStoreMethod.addNewUser(
              name: user.displayName!,
              bio: bio,
              about: about,
              email: user.email!,
              username: user.email!.split('@')[0],
              photoURL: user.photoURL!,
              links: links,
              user: user,
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      ShowSnackBar(
        context: context,
        text: error.message,
      );
    }
  }

  Future signUpWithEmail({
      required String name,
      required String bio,
      required String about,
      required String email,
      required String username,
      required String password,
    required List<Map<String,dynamic>> links,
      required String photoURL,
      required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      String imageUrl =  photoURL;
      await fireStoreMethod.addNewUser(
          name: name,
          bio: bio,
          about: about,
          email: email,
          username: username,
          photoURL: imageUrl,
        links:links,
          user: user);
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> Sign_in_with_EmailAndPassword(
      {required emailAddress, required password, required context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code == 'user-not-found') {
        ShowSnackBar(
          context: context,
          text: 'No user found for : $emailAddress .',
        );
      } else if (e.code == 'wrong-password') {
        ShowSnackBar(
          context: context,
          text: 'Wrong password provided for that user.',
        );
      } else if (e.code == 'invalid-email') {
        ShowSnackBar(
          context: context,
          text: 'Invalid email format',
        );
      }
    }
  }

  Future<String> checkEmail(String email) async {


    try {
      // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      // if (!emailRegex.hasMatch(email)) {
      //   return 'Please enter a valid email address.';
      // }
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        return 'Email address is already in use.';
      } else {
        return '';
      }
    } on FirebaseAuthException catch (e) {
      if (e.message == 'The email address is badly formatted.') {
        return 'Please enter a valid email address.';
      } else if (e.toString().contains('network error')) {
        return 'There is no internet connection';
      } else {
        return "${e.message}";
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  Future<bool> isUsernameExists(String username) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }
}
