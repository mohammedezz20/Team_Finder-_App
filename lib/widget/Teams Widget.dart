import 'package:advanced_project/moadels/TeamModel.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../Screens/teamDetailsScreen/teamDescriptionMainScreen.dart';
import '../moadels/membersmodel.dart';
import '../res/assets_res.dart';
import '../SizeCalc.dart';

class TeamsWidget extends StatelessWidget {


    double? progress = Random().nextDouble();
TeamModel teamdata;
TeamsWidget({required this.teamdata});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width-20;
    return BlocConsumer<TeamCubit,TeamStates>(builder: (context,state){
      var cubit=TeamCubit.get(context);
      return InkWell(
        onTap: (){
          cubit.currentTeam=teamdata;
          cubit.getTasks(cubit.currentTeam?.teamID);
          List<Member> members=teamdata.members;
          cubit.userRole(members);
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>new TeamDescriptionMainScreen(
                teamModel: teamdata,
              )));
        },
        splashColor: Colors.grey,
        child: Ink(
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: getHeight(context, 10)),
            child: Column(
              children: [
                Container(
                  height: getHeight(context, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child:  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      backgroundColor:Color(0xffb1d5f5) ,
                      value: progress,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff47b2ff),),

                    ),
                  ),
                ),
                SizedBox(height: getHeight(context, 10),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: getWidth(context, 50),
                        height: getHeight(context, 50),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black,
                                width: getWidth(context, 1.5))
                        ),
                        child: teamdata.logoURL==''?Container(
                          width: getWidth(context, 50),
                          height: getHeight(context, 50),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            teamdata.teamName.substring(0,2).toUpperCase(),
                            style: TextStyle(fontSize: 23,
                                fontWeight: FontWeight.w400,color: Colors.white),),
                        ):CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(AssetsRes.LOADING),
                          radius: getWidth(context,25),
                          child: ClipOval(
                            child: Image(
                              height: getHeight(context, 50),
                              width: getWidth(context, 50),
                              image: NetworkImage(teamdata.logoURL),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          teamdata.teamName,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: getHeight(context, 8),),
                        SizedBox(
                          width: getWidth(context, width-getWidth(context, 80)),
                          child: Text(
                            teamdata.teamDescription,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Spacer(),
                    // Column(
                    //   children: [
                    //     Text(
                    //       "Team Member",
                    //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    //     ),
                    //     SizedBox(height: 8.h,),
                    //     SizedBox(
                    //       height: 55,
                    //       width: width/2.1,
                    //       child: ListView.separated(
                    //         separatorBuilder: (context, index) => SizedBox(
                    //           width: width * .01,
                    //         ),
                    //         itemBuilder: (context, index) => Container(
                    //           width: 46,
                    //           height: 46,
                    //           decoration: BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             border: Border.all(
                    //               color: Colors.grey,
                    //               width: 1,
                    //             ),
                    //           ),
                    //           child: const CircleAvatar(
                    //             radius: 23,
                    //             backgroundImage: NetworkImage(
                    //                 'https://th.bing.com/th/id/OIP.g9JQBsgn1JtJ4WirA1--IQHaHa?pid=ImgDet&rs=1'),
                    //           ),
                    //         ),
                    //         scrollDirection: Axis.horizontal,
                    //         itemCount: 10,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),

              ],
            ),
          ),
        ),
      );
    }, listener: (context,staet){});
  }
}
