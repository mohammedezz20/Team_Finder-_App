import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Screens/Layout/NotificationScreen.dart';
import '../../../Screens/Layout/teamsScreen.dart';
import '../../../moadels/UserModel.dart';
import '../../Network/FireStoreMethod.dart';
import '../../Network/auth_method.dart';

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
   }
 List<Widget> screens=[
   TeamsScreen(),
   NotificationScreen(),
   const Text("chat"),
 ];

}