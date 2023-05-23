import 'dart:io';

import 'package:advanced_project/shared/cubit/loginCubit/logincubit.dart';
import 'package:advanced_project/SizeCalc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../shared/Colors.dart';
import '../shared/cubit/loginCubit/loginstates.dart';
import 'choosePickType.dart';

class Image_Picker extends StatelessWidget {


  var pickByCameraFunction;
  var pickByGalleryFunction;
 var imagePath;
  var height;
  var width;
  Image_Picker({
    required this.pickByCameraFunction,
    required this.pickByGalleryFunction,
    required this.imagePath,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Logincubit, LoginStates>(
        builder: (context, state) {

          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffd9d9d9)),
                ),
                Container(
                  height: height,
                  width: width,
                  decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.black),
                          image: DecorationImage(
                            image: FileImage(
                                File(imagePath)),
                            fit: BoxFit.cover,
                          ))


                ),
                Positioned(
                  bottom: getHeight(context, 5),
                  right: getWidth(context, 5),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return choosePickType(
                            pickByCamera: pickByCameraFunction,
                            pickByGallery: pickByGalleryFunction,);
                        },
                      );
                    },
                    child: Container(
                      height: getHeight(context, 40),
                      width: getWidth(context, 40),
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
