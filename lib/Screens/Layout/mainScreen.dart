
import 'package:advanced_project/SizeCalc.dart';
import 'package:advanced_project/shared/Colors.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../profileScreen.dart';



class MianScreen extends StatefulWidget {
  const MianScreen({super.key});

  @override
  State<MianScreen> createState() => _MianScreenState();
}

class _MianScreenState extends State<MianScreen> {

  @override
  void initState() {
    AppCubit.get(context).loadUserData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    // TODO: implement build
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {

          var cubit = AppCubit.get(context);
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(icon: Icon(Icons.logout), onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                color: Colors.black,),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                backgroundColor: appbarColor,
                elevation: 6,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context){
                              return ProfileScreen(user: cubit.usermodel);
                            }));
                      },
                      splashColor: Colors.blue[100],
                      child: Ink(

                        child:  CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: getHeight(context, 25),

                          child:ClipOval(

                            child: CachedNetworkImage(
                              height: getHeight(context, 50),
                              width: getHeight(context, 50),
                              fit: BoxFit.contain,
                              imageUrl: '${cubit.usermodel?.photoURL}',
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
             body: TabBarView(children: cubit.screens,),
              bottomNavigationBar: Container(
                color: appbarColor,

                height: 60,

                child: TabBar(

                  labelColor: const Color(0xFF343434),

                  indicator: UnderlineTabIndicator(
                    borderRadius:BorderRadius.circular(30) ,
                    borderSide: BorderSide(color: Colors.black, width:3),
                    insets: EdgeInsets.fromLTRB((w/3)*.2, 0.0, (w/3)*.2, 56),
                  ),
                  unselectedLabelColor: Colors.black,
                  tabs: const [

                    Tab(
                      iconMargin: EdgeInsets.only(top: 4),
                      icon: Icon(Icons.groups_outlined),
                      text: 'Teams',
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 4),
                      icon: Icon(Icons.notifications_outlined),
                      text: 'Notifications',
                    ),
                    Tab(
                      iconMargin: EdgeInsets.only(top: 4),
                      icon: Icon(Icons.mode_comment_outlined),
                      text: 'Chat',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}












/*
*  body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "============================================================="),
                    Text('${cubit.usermodel?.toMap()}'),
                    Text(
                        "==============================================================="),
                    Text(cubit.auth.user!.email.toString()),
                    Text(
                        "==============================================================="),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Text("sign out"))
                  ],
                ),
              ),
* */