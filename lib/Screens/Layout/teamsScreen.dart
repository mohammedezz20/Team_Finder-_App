import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widget/Teams Widget.dart';
import '../../widget/teamTextFieldWidget .dart';
import '../AddTeamScreen.dart';
import '../searchTeamScreen.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({Key? key}) : super(key: key);

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  void initState() {
    TeamCubit.get(context).getTeamsData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return BlocConsumer<TeamCubit, TeamStates>(
              builder: (context, state) {

                var teamCubit = TeamCubit.get(context);
                
                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTeamScreen()));
                      teamCubit.category.remove("All");
                    },
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                  body: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TeamTextFieldWidjet(
                              controller: teamCubit.searchTeamController,
                              text: "Search for team",
                              maxLines: 1,
                              suffixIcon: Icons.search,
                              prefixIcon: Icons.menu,
                              suffixpressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SearchTeamScreen()));
                                teamCubit.teamSerchRes.clear();
                                teamCubit.category.add("All");
                              },
                            ),
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) => TeamsWidget(
                                        teamdata: teamCubit.teamsList[index],
                                      ),
                                  separatorBuilder: (conext, index) =>
                                      const Divider(
                                          height: 10,
                                          color: Colors.black,
                                          thickness: 2),
                                  itemCount: teamCubit.teamsList.length),
                            ),
                          ],
                        ),
                      ),
                      if (state is GetTeamDataLoadingStates) ...[
                        SpinKitSpinningLines(
                          color: Colors.blue,
                          size: 100,
                          itemCount: 8,
                          lineWidth: 3,
                        ),
                      ],
                    ],
                  ),
                );
              },
              listener: (context, state) {});
        },
        listener: (context, state) {});
  }
}
