import 'package:advanced_project/SizeCalc.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamState.dart';
import 'package:advanced_project/shared/cubit/teamCubit/teamcubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Button.dart';
import 'ShowSnakebar.dart';
import 'teamTextFieldWidget .dart';

class AddNewLinkDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: getHeight(context, 60),
                    child: ListView.builder(
                      itemCount: cubit.images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              cubit.chosePlatform(cubit.images[index]);
                            },
                            child: Ink(
                              child: Image.asset(
                                cubit.images[index]['path'],
                                height: getHeight(context, 35),
                                width: getHeight(context, 35),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      if(cubit.selectedItem['path'] != null)...[Image.asset(
                        "${cubit.selectedItem['path']}",
                        height: getHeight(context, 30),
                        width: getWidth(context, 30),
                      ),
                        SizedBox(width: getWidth(context, 10),),
                        Text("${cubit.selectedItem['title']}",style: TextStyle(fontSize: 18),)
                      ],
                      
                      
        ]
                  ),
                    SizedBox(height: getHeight(context, 10),),
                  TeamTextFieldWidjet(
                    controller: cubit.editProfilelinks,
                    text: "link...",
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: getHeight(context, 20),
                  ),
                  defaultButton(
                      height: getHeight(context, 40),
                      radius: 5,
                      function: () {
                        if (cubit.editProfilelinks.text == '') {
                          Navigator.pop(context);
                        } else {
                          print("=======================================================");
                          print(cubit.editProfilelinks.text);
                          cubit.addlink({
                          'link': "${cubit.editProfilelinks.text}",
                          'title':"${cubit.selectedItem['title']}"
                          });

                          cubit.chosePlatform({'title':'Choose PlatForm',"link":''});
                          cubit.editProfilelinks.clear();
                          Navigator.pop(context);
                        }
                      },
                      text: 'Add Link',
                      isupper: false),
                ],
              ),
            ),
          );
        },
        listener: (contect, state) {});
  }
}
