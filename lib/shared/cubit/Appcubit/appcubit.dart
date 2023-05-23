import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_zimkit/services/services.dart';

import '../../../Screens/Layout/ChatScreen.dart';
import '../../../Screens/Layout/NotificationScreen.dart';
import '../../../Screens/Layout/teamsScreen.dart';
import '../../../moadels/UserModel.dart';
import '../../Network/remote/FireStoreMethod.dart';
import '../../Network/remote/auth_method.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  Auth auth=Auth();
  FireStoreMethod fireStoreMethod=FireStoreMethod();
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

    await ZIMKit().connectUser(
        id: usermodel?.username??'user',
        name:usermodel?.name ??"user",
        avatarUrl: usermodel?.photoURL??'');
   }
 List<Widget> screens=[
   TeamsScreen(),
   NotificationScreen(),
   ChatScreen(),
 ];



}