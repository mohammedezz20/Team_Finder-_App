import 'dart:io';

import 'package:advanced_project/res/assets_res.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zego_zimkit/services/services.dart';

import '../../../Screens/Layout/ChatScreen.dart';
import '../../../Screens/Layout/NotificationScreen.dart';
import '../../../Screens/Layout/teamsScreen.dart';
import '../../../moadels/UserModel.dart';
import '../../Network/remote/FireStoreMethod.dart';
import '../../Network/remote/auth_method.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  Auth auth = Auth();
  FireStoreMethod fireStoreMethod = FireStoreMethod();
  UserModel? usermodel;

  Future<void> loadUserData() async {
    UserModel userData = await fireStoreMethod.getUserData(auth.user!.uid);
    usermodel = userData;
    emit(AppLoadUserDataStates());
    print("hello from connect user in appcubit");
    print("==========================================");
    print(usermodel?.username);
    print(usermodel?.name);
    print(usermodel?.photoURL);
    print("==========================================");
    await ZIMKit().
    connectUser(id: userData.username,avatarUrl: userData.photoURL,name: userData.name);
  }

  List<Widget> screens = [
    TeamsScreen(),
    NotificationScreen(),
    ChatScreen(),
  ];

  String? extractUsernameFromLink(String link) {
    if (link.contains('twitter.com')) {
      // Twitter URL
      RegExp regExp = RegExp(
          r'(?:(?:http|https):\/\/)?(?:www.)?twitter\.com\/([A-Za-z0-9_]+)');
      RegExpMatch? match = regExp.firstMatch(link);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    } else if (link.contains('instagram.com')) {
      // Instagram URL
      RegExp regExp = RegExp(
          r'(?:(?:http|https):\/\/)?(?:www.)?instagram\.com\/([A-Za-z0-9_.]+)');
      RegExpMatch? match = regExp.firstMatch(link);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    } else if (link.contains('facebook.com')) {
      // Facebook URL
      RegExp regExp = RegExp(
          r'(?:(?:http|https):\/\/)?(?:www.)?facebook\.com\/([A-Za-z0-9.]+)');
      RegExpMatch? match = regExp.firstMatch(link);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    } else if (link.contains('github.com')) {
      // GitHub URL
      RegExp regExp = RegExp(
          r'(?:(?:http|https):\/\/)?(?:www.)?github\.com\/([A-Za-z0-9-]+)');
      RegExpMatch? match = regExp.firstMatch(link);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    } else if (link.contains('linkedin.com')) {
      // LinkedIn URL
      RegExp regExp = RegExp(
          r'(?:(?:http|https):\/\/)?(?:www.)?linkedin\.com\/(?:in|company)\/([A-Za-z0-9-]+)');
      RegExpMatch? match = regExp.firstMatch(link);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    } else if (link.contains('behance.net')) {
      // Behance URL
      RegExp regExp = RegExp(
          r'(?:(?:http|https):\/\/)?(?:www.)?behance\.net\/([A-Za-z0-9-]+)');
      RegExpMatch? match = regExp.firstMatch(link);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    } else if (link.contains('dribbble.com')) {
      // Dribbble URL
      RegExp regExp = RegExp(
          r'(?:(?:http|https):\/\/)?(?:www.)?dribbble\.com\/([A-Za-z0-9-]+)');
      RegExpMatch? match = regExp.firstMatch(link);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    } else if (link.contains('youtube.com')) {
      // YouTube URL
      List<String> username = link.split("@");
      print(username);
      return username.last.substring(0, username.last.length - 1);
    } else if (link.contains('pinterest.com')) {
      // Pinterest URL
      RegExp regExp = RegExp(
          r'(?:(?:http|https):\/\/)?(?:www.)?pinterest\.com\/([A-Za-z0-9-]+)');
      RegExpMatch? match = regExp.firstMatch(link);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    }

    return null; // Return null if no username is found or the link is not supported
  }

  void launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  String extractFileNameFromLink(String link) {
    Uri uri = Uri.parse(link);
    String path = uri.path;
    List<String> pathSegments = path.split('%2F');
    String fileNameWithExtension = pathSegments.last;
    String fileName = fileNameWithExtension.split('.').first;
    return fileName;
  }

  List links = [];
  var linkTitl;
  var Editimage = false;
  var editProfileName = TextEditingController();
  var editProfileBio = TextEditingController();
  var editProfileAbout = TextEditingController();
  var editProfilelinks = TextEditingController();

  List images = [
    {'title': "github", 'path': AssetsRes.GITHUB},
    {'title': "LinkedIn", 'path': AssetsRes.LINKEDIN},
    {'title': "FaceBook", 'path': AssetsRes.FACEBOOK},
    {'title': "Behance", 'path': AssetsRes.BEHANCE},
    {'title': "Instgram", 'path': AssetsRes.INSTAGRAM},
    {'title': "Dribbble", 'path': AssetsRes.DRIBBBLE},
    {'title': "Youtube", 'path': AssetsRes.YOUTUBE},
    {'title': "Pinterest", 'path': AssetsRes.PINTEREST},
  ];
  var selectedItem = {'title': 'Choose PlatForm', "link": ''};
  chosePlatform(var item) {
    selectedItem = item;
    emit(ChoosePlatFormState());
  }

  addlink(link) {
    links.add(link);
    emit(AddlinkState());
  }

  removeLink(index) {
    links.removeAt(index);
    emit(RemovelinkState());
  }
  var editimage=false;
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
      editimage =true;
      emit(pickImageState());
    } else {
      print("You have not taken an image");
      emit(pickImagefaildState("You have not taken an image"));
    }

    Navigator.pop(context);
  }

  updateImageState(){
    editimage=true;
    emit(UpdateImageState());
  }
  UndoFromImgaeedit(){
    editimage=false;
    emit(removeUpdateImageState());
  }
  Future<void> updateprofiledata(var context)async{
    emit(UpdateProfileDataLoadingState());
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try{
     await users.doc(auth.user?.uid).update({
       'name':editProfileName.text,
       'bio':editProfileBio.text,
       'about':editProfileAbout.text,
       'links':links,
     });
     loadUserData();
     print(usermodel?.toMap().toString());
     emit(UpdateProfileDataSuccessState());
     Navigator.pop(context);
     Navigator.pop(context);

    }catch(error){
      emit(UpdateProfileDataFaildState(error.toString()));
    }
  }
}
