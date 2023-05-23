import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:advanced_project/SizeCalc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/NotificationWidget.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key}) : super(key: key);
List Notificatios=[
  {
    'username':'Ali Ahmed',
    'team':'Icpc Team',
    'request':false,
  },
  {
    'username':'Mohammed abdullah',
    'team':'First Team',
    'request':true,
  },
  {
    'username':'Alaa Ali',
    'team':'GDSC Team',
    'request':false,
  },
  {
    'username':'Mohammed abdullah',
    'team':'First Team',
    'request':true,
  },
  {
    'username':'Alaa Ali',
    'team':'GDSC Team',
    'request':false,
  },

];

  @override
  Widget build(BuildContext context) {
 return BlocConsumer<AppCubit,AppStates>
   (builder: (context,state){
     return Padding(
       padding:  EdgeInsets.all(getWidth(context, 20)),
       child: ListView.separated(itemBuilder: (context,index){
         return NotificationWidget(userName:Notificatios[index]['username'] ,
           teamName: Notificatios[index]['team'], isRequest: Notificatios[index]['request'],);

       },
           separatorBuilder:(conext,index)=>const
           Divider(height: 10,color: Colors.black,thickness: 2),
           itemCount: Notificatios.length),
     );
 },
     listener: (context,state){});
  }
}
