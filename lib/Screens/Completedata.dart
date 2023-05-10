import 'package:advanced_project/shared/cubit/loginCubit/logincubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/assets_res.dart';
import '../shared/Colors.dart';
import '../shared/cubit/loginCubit/loginstates.dart';
import '../widget/Button.dart';
import '../widget/CvViewer.dart';
import '../widget/ImagePicker.dart';
import '../widget/Upload_CV.dart';
import '../widget/text_Field.dart';

class Completedata extends StatelessWidget {
  final bool? isSocial;
  const Completedata(this.isSocial, {super.key});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return BlocConsumer<Logincubit,LoginStates>(
        builder: (context, state) {
          var cubit =Logincubit.obj(context);
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsRes.BACKGROUND),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: statusBarHeight * 1.4, right: 28.w, left: 28.w),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //********************PickImage*****************
                        const Image_Picker(),
                        //********************Linkedin*****************
                        SizedBox(
                          height: 50.h,
                        ),
                        DefaultTextField(
                          controller: cubit.registerGithubNameController,
                          text: "Github Account",
                          suffixIcon: null,
                          ispass: false,
                          suffixpressed: () {},
                          hint: "https://github.com",
                        ),
                        //********************Github*****************
                        SizedBox(
                          height: 30.h,
                        ),
                        DefaultTextField(
                          controller:  cubit.registerLinkedInNameController,
                          text: "LinkedIn Account",
                          suffixIcon: null,
                          ispass: false,
                          suffixpressed: () {},
                          hint: "https://www.linkedin.com",
                        ),

                        //********************UploadCV*****************
                        SizedBox(
                          height: 30.h,
                        ),
                        UploadCV(
                          text: "Upload your CV",
                          logo: AssetsRes.UPLOAD,
                          background: const Color(0xffDBEBF6),
                          height: 50.h,
                          width: double.infinity,
                          function: () async {
                            cubit.file_path = await Logincubit.obj(context).select_file();
                            Logincubit.obj(context).showcvstate();
                          },
                          radius: 5,
                        ),
                        Visibility(
                          visible: Logincubit.obj(context).showcv,
                          child: CvViewer(
                            text: cubit.file_path,
                          ),
                        ),
                        //********************RegisterButton*****************
                        SizedBox(
                          height: 30.h,
                        ),
                        defaultButton(
                            function: () {
                             if(isSocial==false) {
                                cubit.register_with_email(context: context);
                              }
                             else
                               {
                                 cubit.register_with_Google(context: context,isNew: true);
                               }
                            },
                            text: 'Register',
                            isupper: false,
                            radius: 6,
                            background: buttonColor),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
