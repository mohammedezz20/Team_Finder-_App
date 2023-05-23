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
  Sign_in_with_google(
      {required BuildContext context,
      required String githubLink,
      required String linkedinLink,
      required Future<String> cV_URL,
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
              email: user.email!,
              name: user.displayName!,
              username: user.email!.split('@')[0],
              githubLink: githubLink,
              linkedinLink: linkedinLink,
              photoURL: user.photoURL!,
              CV_URL: cV_URL,
              user: user);
        }
      }
    } on FirebaseAuthException catch (error) {
      ShowSnackBar(
        context: context,
        text: error.message,
      );
    }
  }

  Future signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context,
      required String name,
      required String username,
      required String githubLink,
      required String linkedinLink,
      required Future<String> photoURL,
      required Future<String> cV_URL}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      String imageUrl = await photoURL;
      await fireStoreMethod.addNewUser(
          email: email,
          name: name,
          username: username,
          githubLink: githubLink,
          linkedinLink: linkedinLink,
          photoURL: imageUrl,
          CV_URL: cV_URL,
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
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }

    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        return 'Email address is already in use.';
      } else {
        return 'Email address is available.';
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
