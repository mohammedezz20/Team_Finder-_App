import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamDescriptionMainScreen extends StatelessWidget {
  const TeamDescriptionMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(builder: (context,state){
     return Container();
   }, listener: (context,state){});
  }
}
