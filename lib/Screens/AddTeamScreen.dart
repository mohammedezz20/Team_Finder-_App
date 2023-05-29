import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../moadels/TeamModel.dart';
import '../widget/Button.dart';
import '../widget/ImagePicker.dart';
import '../SizeCalc.dart';
import '../widget/ShowSnakebar.dart';
import '../widget/addDataRow.dart';
import '../widget/addNewSkillDialog.dart';
import '../widget/teamTextFieldWidget .dart';
import '../widget/choosePickType.dart';
import '../widget/dropdown_button.dart';
import '../widget/requiredSkillsWidget.dart';

class AddTeamScreen extends StatelessWidget {
   AddTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamCubit, TeamStates>(
        builder: (context, state) {
          var cubit = TeamCubit.get(context);
          return Material(
            child: InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                backgroundColor: Color(0xffEEEEEE),
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        cubit.selectedValue=null;
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.black,
                      )),
                  centerTitle: true,
                  title: const Text(
                   "Add New Team",
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
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(context, 40),
                      vertical: getWidth(context, 15)),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Image_Picker(
                        pickByCameraFunction: () {
                          cubit.imageSelector(context, "camera");
                          cubit.usingimagestate();
                        },
                        pickByGalleryFunction: () {
                          cubit.imageSelector(context, "gallery");
                          cubit.usingimagestate();
                        },
                        imagePath: cubit.imageFile.path,
                        height: getHeight(context, 160),
                        width: getWidth(context, 160),
                      ),
                      SizedBox(height: getHeight(context, 20),),

                      TeamTextFieldWidjet(
                        controller: cubit.teamNameController,
                        text: "Team name...",
                        maxLines: 1,
                      ),
                      SizedBox(height: getHeight(context, 20),),
                      Dropdown_button(
                        onopen: (isOpen){
                          if (!isOpen) {
                            cubit.teamDropDownListController.clear();

                          }
                        },
                      ),
                      SizedBox(height: getHeight(context, 20),),

                      TeamTextFieldWidjet(
                        controller: cubit.teamDescriptionController,
                        text: "Team description...",
                        maxLines: 8,
                      ),
                      AddDataRow(function:  () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddNewSkillDialog();
                          },
                        );

                      }, text: "Required Skills",),
                      Visibility(visible: cubit.skillShow,
                          child: RequiredSkillsWidjet()),
                      SizedBox(height: getHeight(context, 20),),
                      defaultButton(
                          function: () {
                            if(cubit.teamNameController.text=='')
                              {
                                ShowSnackBar(
                                  context: context,
                                  text: "Team name is required"
                                );
                              }
                            else if(cubit.skillsWidget.length==0)
                              {
                                ShowSnackBar(
                                    context: context,
                                    text: "Team required skills is required"
                                );
                              }
                            else{
                              cubit.addNewTeam();
                              Navigator.pop(context);
                            }

                          },
                          text: 'Create team',
                          height: getHeight(context, 45),
                          radius: 5,
                          isupper: false)
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
    ;
  }
}
