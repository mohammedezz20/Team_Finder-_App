import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/Teams Widget.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return BlocConsumer<AppCubit,AppStates>(
      builder: (context,state){
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
              itemBuilder: (context,index)=>TeamsWidget(),
              separatorBuilder: (conext,index)=>const
              Divider(height: 10,color: Colors.black,thickness: 2),
              itemCount: 4),
        );
      },
      listener: (context,state){});
  }
}
