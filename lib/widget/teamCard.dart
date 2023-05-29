import 'package:advanced_project/moadels/TeamModel.dart';
import 'package:advanced_project/moadels/taskmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Screens/teamDetailsScreen.dart';
import '../SizeCalc.dart';
import '../res/assets_res.dart';
import '../shared/cubit/teamCubit/teamState.dart';
import '../shared/cubit/teamCubit/teamcubit.dart';


class TeamCard extends StatelessWidget {
   TeamCard({super.key,required this.teammodel});
TeamModel teammodel;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<TeamCubit,TeamStates>(
        builder: (context,state){
          var cubit=TeamCubit.get(context);
         return InkWell(
            onTap: (){
cubit.getTeamMembersData(teammodel.members);
Navigator.push(context, MaterialPageRoute(builder:(context){
  cubit.prevewtask=true;
  cubit.skillsWidget=teammodel.requiredSkills;
  return TeamDetailsScreen(team: teammodel);
} ));
            },
            splashColor: Colors.grey,
            child: Ink(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffEEEEEE),
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
                      height: 55,
                      child: Row(
                        children: [
                          const Spacer(),
                          Container(
                            width: getWidth(context, 50),
                            height: getHeight(context, 50),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black,
                                    width: getWidth(context, 1.5))
                            ),
                            child: teammodel.logoURL==''?Container(
                              width: getWidth(context, 50),
                              height: getHeight(context, 50),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                teammodel.teamName.substring(0,2).toUpperCase(),
                                style: TextStyle(fontSize: 23,
                                    fontWeight: FontWeight.w400,color: Colors.white),),
                            ):
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(AssetsRes.LOADING),
                              radius: getWidth(context,25),
                              child: ClipOval(
                                child: Image(
                                  height: getHeight(context, 50),
                                  width: getWidth(context, 50),
                                  image: NetworkImage(teammodel.logoURL),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                teammodel.teamName,
                                style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                teammodel.teamCategory,
                                style:
                                TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Spacer(
                            flex: 6,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width * .75,
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(5)),
                        child:  Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                          child: Text(
                            teammodel.teamDescription,
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),



                    if(teammodel.role=='')...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: (){
                              
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width:getWidth(context,100),
                              height: getHeight(context, 30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text(
                                "join Request",
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
    },
        listener:(context,state){} );

  }
}
