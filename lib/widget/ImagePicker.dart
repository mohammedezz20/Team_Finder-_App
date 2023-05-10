import 'dart:io';

import 'package:advanced_project/shared/cubit/loginCubit/logincubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/Colors.dart';
import '../shared/cubit/loginCubit/loginstates.dart';

class Image_Picker extends StatelessWidget {
  const Image_Picker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Logincubit, LoginStates>(
        builder: (context, state) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200.h,
                  width: 200.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffd9d9d9)),
                ),
                Container(
                  height: 200.h,
                  width: 200.h,
                  decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.black),
                          image: DecorationImage(
                            image: FileImage(
                                File(Logincubit.obj(context).imageFile.path)),
                            fit: BoxFit.cover,
                          ))


                ),
                Positioned(
                  bottom: 5.h,
                  right: 5.w,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Pick Image From',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Logincubit.obj(context).imageSelector(
                                              context, "gallery");
                                          Logincubit.obj(context).usingimagestate();

                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  buttonColor),
                                        ),
                                        child: const Text('Gallery'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Logincubit.obj(context)
                                              .imageSelector(context, "camera");
                                          Logincubit.obj(context).usingimagestate();

                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  buttonColor),
                                        ),
                                        child: const Text('Camera'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: buttonColor,
                          border: Border.all(color: Colors.white, width: 2)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),

                    ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
