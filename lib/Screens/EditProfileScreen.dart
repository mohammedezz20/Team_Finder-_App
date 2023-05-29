import 'dart:io';

import 'package:advanced_project/shared/cubit/Appcubit/appcubit.dart';
import 'package:advanced_project/shared/cubit/Appcubit/appstate.dart';
import 'package:advanced_project/widget/Button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SizeCalc.dart';
import '../moadels/UserModel.dart';
import '../shared/Colors.dart';
import '../widget/AddNewLinkDialog.dart';
import '../widget/ImagePicker.dart';
import '../widget/addNewSkillDialog.dart';
import '../widget/choosePickType.dart';
import '../widget/text_Field.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key, required this.user}) : super(key: key);
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          final double statusBarHeight = MediaQuery.of(context).padding.top;
          final double width = MediaQuery.of(context).size.width;
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: width / 2,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -(width / 2),
                          child: Container(
                            height: width,
                            width: width,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffBAE6FF),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -getHeight(context, 60),
                          width: width,
                          // child: Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     cubit.editimage == true
                          //         ? Container(
                          //             height: getHeight(context, 160),
                          //             width: getWidth(context, 160),
                          //             decoration: BoxDecoration(
                          //               shape: BoxShape.circle,
                          //               border: Border.all(
                          //                   width: 5, color: Colors.grey),
                          //             ),
                          //             child: ClipOval(
                          //               child: CachedNetworkImage(
                          //                 fit: BoxFit.cover,
                          //                 imageUrl: '${user?.photoURL}',
                          //                 height: getHeight(context, 160),
                          //                 width: getWidth(context, 160),
                          //                 progressIndicatorBuilder: (context,
                          //                         url, downloadProgress) =>
                          //                     CircularProgressIndicator(
                          //                         value: downloadProgress
                          //                             .progress),
                          //                 errorWidget: (context, url, error) =>
                          //                     Icon(Icons.error),
                          //               ),
                          //             ),
                          //           )
                          //         : Image_Picker(
                          //             pickByCameraFunction: () {
                          //               cubit.imageSelector(context, "camera");
                          //             },
                          //             pickByGalleryFunction: () {
                          //               cubit.imageSelector(context, "gallery");
                          //             },
                          //             imagePath: cubit.imageFile.path,
                          //             height: getHeight(context, 200),
                          //             width: getWidth(context, 200),
                          //           ),
                          //   ],
                          // ),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: getHeight(context, 160),
                                  width: getHeight(context, 160),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffd9d9d9)),
                                ),
                                Container(
                                    height: getHeight(context, 160),
                                    width: getHeight(context, 160),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: Colors.black),
                                        image: DecorationImage(
                                          image: cubit.editimage
                                              ? FileImage(
                                                  File(cubit.imageFile.path))
                                              : NetworkImage(user!.photoURL)
                                                  as ImageProvider<Object>,
                                          fit: BoxFit.cover,
                                        ))),
                                Positioned(
                                  bottom: getHeight(context, 5),
                                  right: getWidth(context, 5),
                                  child: InkWell(
                                    onTap: () {
                                      print("===============================");
                                      // cubit.updateImageState();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return choosePickType(
                                            pickByCamera: () {
                                              cubit.imageSelector(
                                                  context, "camera");
                                            },
                                            pickByGallery: () {
                                              cubit.imageSelector(
                                                  context, "gallery");
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: getHeight(context, 40),
                                      width: getWidth(context, 40),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: buttonColor,
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   bottom: getHeight(context, 5),
                                //   right: getWidth(context, 5),
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       cubit.UndoFromImgaeedit();
                                //     },
                                //     child: Container(
                                //       height: getHeight(context, 40),
                                //       width: getWidth(context, 40),
                                //       decoration: BoxDecoration(
                                //           shape: BoxShape.circle,
                                //           color: buttonColor,
                                //           border: Border.all(
                                //               color: Colors.white, width: 2)),
                                //       child: const Icon(
                                //         Icons.delete,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back)),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 70),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: getHeight(context, 30),
                        left: getHeight(context, 30),
                        bottom: getHeight(context, 20)),
                    child: Column(
                      children: [
                        //*********************Image*************************

                        //*********************Name*************************
                        SizedBox(
                          height: getHeight(context, 10),
                        ),
                        DefaultTextField(
                          controller: cubit.editProfileName,
                          text: "Name",
                          suffixIcon: null,
                          ispass: false,
                          suffixpressed: () {},
                          hint: "Enter your full name",
                        ),
                        //*********************bio*************************
                        SizedBox(
                          height: getHeight(context, 10),
                        ),
                        DefaultTextField(
                          controller: cubit.editProfileBio,
                          text: "Bio",
                          suffixIcon: null,
                          ispass: false,
                          suffixpressed: () {},
                          hint: "bio",
                        ),
                        //********************about*****************
                        SizedBox(
                          height: getHeight(context, 10),
                        ),
                        DefaultTextField(
                          controller: cubit.editProfileAbout,
                          text: "About",
                          suffixIcon: null,
                          ispass: false,
                          maxline: 4,
                          suffixpressed: () {},
                          hint: "about",
                        ),
                        //*********************Sochial media*************************

                        SizedBox(
                          height: getHeight(context, 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Links",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddNewLinkDialog();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.add_box,
                                  size: 30,
                                ))
                          ],
                        ),
                        Wrap(
                          children: List.generate(
                            user?.links.length,
                            (index) {
                              var links = cubit.links[index];
                              if (links['title'] != 'cvURL') {
                                print(links.toString());
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: getHeight(context, 3),
                                      bottom: getWidth(context, 3)),
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      cubit.launchURL(Uri.parse(links['link']));
                                    },
                                    child: Ink(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/${links['title'].toString().toLowerCase()}.png',
                                            height: getHeight(context, 35),
                                            width: getHeight(context, 35),
                                          ),
                                          SizedBox(
                                            width: getWidth(context, 5),
                                          ),
                                          Text(
                                              "${cubit.extractUsernameFromLink(links['link'])}"),
                                          Spacer(),
                                          GestureDetector(
                                              onTap: () {
                                                cubit.removeLink(index);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                size: 30,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: getHeight(context, 3),
                                      bottom: getWidth(context, 3)),
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      cubit.launchURL(Uri.parse(links['link']));
                                    },
                                    child: Ink(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: getWidth(context, 18),
                                            backgroundColor: Colors.black,
                                            child: Text(
                                              "CV",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: getWidth(context, 5),
                                          ),
                                          Text("${user?.name}'s CV")
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        ),

                        SizedBox(
                          height: getHeight(context, 10),
                        ),
                        defaultButton(
                            function: () {
cubit.updateprofiledata(context);
                            },
                            text: "Edit data",
                            isupper: false,
                            radius: 10,
                            height: getHeight(context, 50),
                            background: Colors.black)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
