import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../SizeCalc.dart';
import '../shared/cubit/teamCubit/teamcubit.dart';
import '../widget/dropdown_button.dart';
import '../widget/teamCard.dart';
import '../widget/teamTextFieldWidget .dart';

class SearchTeamScreen extends StatelessWidget {
  const SearchTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit,TeamStates>(builder: (context,state){
      var cubit=TeamCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                cubit.category.remove('All');
                cubit.selectedValue=null;
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.black,
              )),
          centerTitle: true,
          title: const Text(
            "Search for teams",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          backgroundColor: Color(0xffEEEEEE),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Container(
              width: getWidth(context, 370),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffBAE6FF),
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: getWidth(context, 15),vertical: getHeight(context, 10)),
          child: Column(
            children: [
              Dropdown_button(
                onopen: (isOpen){
                  if (!isOpen) {
                    cubit.teamDropDownListController.clear();
                  }
                },
              ),
              (state is GetTeamsByCategoryLoadingState)?
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitSpinningLines(
                        color: Colors.blue,
                        size: 100,
                        itemCount: 8,
                        lineWidth: 3,
                      ),
                    ],
                  ),
                ):

              Expanded(
                child: ListView.builder(itemBuilder:
                    (context ,index)=>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TeamCard(teammodel: cubit.teamSerchRes[index],),
                        ),
                    itemCount: cubit.teamSerchRes.length),
              )

            ],
          ),
        ),
      );
    }, listener: (context,state){});
  }
}
