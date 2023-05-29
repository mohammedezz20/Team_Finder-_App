import 'package:advanced_project/shared/cubit/loginCubit/logincubit.dart';
import 'package:advanced_project/SizeCalc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    return BlocConsumer<Logincubit, LoginStates>(
        builder: (context, state) {
          var cubit = Logincubit.obj(context);
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
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
                      top: statusBarHeight * 1.4,
                      right: getWidth(context, 28),
                      left: getWidth(context, 28)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Spacer(),

                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //********************PickImage*****************
                            Image_Picker(
                              pickByCameraFunction: () {
                                Logincubit.obj(context)
                                    .imageSelector(context, "camera");
                                Logincubit.obj(context).usingimagestate();
                              },
                              pickByGalleryFunction: () {
                                Logincubit.obj(context)
                                    .imageSelector(context, "gallery");
                                Logincubit.obj(context).usingimagestate();
                              },
                              imagePath: Logincubit.obj(context).imageFile.path,
                              height: getHeight(context, 200),
                              width: getWidth(context, 200),
                            ),
                            //********************bio*****************
                            SizedBox(
                              height: getHeight(context, 30),
                            ),
                            DefaultTextField(
                              controller: cubit.registerBioController,
                              text: "Bio",
                              suffixIcon: null,
                              ispass: false,
                              suffixpressed: () {},
                              hint: "bio",
                            ),
                            //********************about*****************
                            SizedBox(
                              height: getHeight(context, 20),
                            ),
                            DefaultTextField(
                              controller: cubit.registerAboutController,
                              text: "About",
                              suffixIcon: null,
                              ispass: false,
                              maxline: 4,
                              suffixpressed: () {},
                              hint: "about",
                            ),
                            //********************Linkedin*****************
                            SizedBox(
                              height: getHeight(context, 20),
                            ),
                            DefaultTextField(
                              controller: cubit.registerGithubController,
                              text: "Github Account",
                              suffixIcon: null,
                              ispass: false,
                              suffixpressed: () {},
                              hint: "https://github.com",
                            ),
                            //********************Github*****************
                            SizedBox(
                              height: getWidth(context, 20),
                            ),
                            DefaultTextField(
                              controller: cubit.registerLinkedInController,
                              text: "LinkedIn Account",
                              suffixIcon: null,
                              ispass: false,
                              suffixpressed: () {},
                              hint: "https://www.linkedin.com",
                            ),

                            //********************UploadCV*****************
                            SizedBox(
                              height: getHeight(context, 30),
                            ),
                            UploadCV(
                              text: "Upload your CV",
                              logo: AssetsRes.UPLOAD,
                              background: const Color(0xffDBEBF6),
                              height: getHeight(context, 50),
                              width: double.infinity,
                              function: () async {
                                cubit.file_path = await cubit.select_file();
                                cubit.showcvstate();
                              },
                              radius: 5,
                            ),
                            Visibility(
                              visible: Logincubit.obj(context).showcv,
                              child: CvViewer(
                                text: cubit.file_path,
                                icon: Icons.highlight_remove_outlined,
                                function: () {
                                  cubit.file_path = '';
                                  cubit.showcvstate();
                                },
                              ),
                            ),
                            //********************RegisterButton*****************
                            SizedBox(
                              height: getHeight(context, 30),
                            ),
                            (state is RegisterLoadingState)?
                            Center(
                              child:  SpinKitThreeBounce	(
                                color: Colors.black,
                                size: 30,
                              ),
                            ):
                            defaultButton(
                                function: () {
                                  if (isSocial == false) {
                                    cubit.register_with_email(context: context);
                                  } else {
                                    cubit.register_with_Google(
                                        context: context, isNew: true);
                                  }
                                },
                                text: 'Register',
                                isupper: false,
                                radius: 6,
                                background: buttonColor),
                            SizedBox(
                              height: getHeight(context, 30),
                            ),
                          ],
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
