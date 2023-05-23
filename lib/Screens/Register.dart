import 'package:advanced_project/Screens/LoginScreen.dart';
import 'package:advanced_project/SizeCalc.dart';
import 'package:advanced_project/res/assets_res.dart';
import 'package:advanced_project/shared/cubit/loginCubit/logincubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/Colors.dart';
import '../shared/cubit/loginCubit/loginstates.dart';
import '../widget/Button.dart';
import '../widget/Separator.dart';
import '../widget/ShowSnakebar.dart';
import '../widget/Signinoption.dart';
import '../widget/text_Field.dart';
import 'Completedata.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
   return BlocConsumer<Logincubit,LoginStates>(
    builder: (context,satate){
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
                top: statusBarHeight * 1.4, right: getWidth(context, 28), left: getWidth(context, 28)),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Register",
                      style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: getHeight(context, 15),
                    ),
                    DefaultTextField(
                      controller: cubit.registerNameController,
                      text: "Name",
                      suffixIcon: null,
                      ispass: false,
                      suffixpressed: () {},
                      hint: "Enter your full name",
                    ),
                    SizedBox(
                      height: getHeight(context, 15),
                    ),
                    DefaultTextField(
                      controller: cubit.registerUserNameController,
                      text: "Username",
                      suffixIcon: null,
                      ispass: false,
                      suffixpressed: () {},
                      hint: "Enter your Username",
                    ),
                    SizedBox(
                      height: getHeight(context, 15),
                    ),
                    DefaultTextField(
                      controller: cubit.registerEmailController,
                      text: "Email",
                      suffixIcon: null,
                      ispass: false,
                      suffixpressed: () {},
                      hint: "Enter your email",
                    ),
                    SizedBox(
                      height: getHeight(context, 15),
                    ),
                    DefaultTextField(
                      controller: cubit.registerPasswordController,
                      text: "Password",
                      suffixIcon: cubit.icon,
                      ispass: cubit.showpassword,
                      suffixpressed: () {
                        cubit.changpasswordstate();
                      },
                      hint: "**************",
                    ),
                    SizedBox(
                      height: getHeight(context, 15),
                    ),
                    DefaultTextField(
                      controller: cubit.registerConfirmPasswordController,
                      text: "Confirm Password",
                      suffixIcon: cubit.icon,
                      ispass: cubit.showpassword,
                      suffixpressed: () {
                    cubit.changpasswordstate();
                      },
                      hint: "**************",
                    ),

                    SizedBox(
                      height: getHeight(context, 25),
                    ),
                    defaultButton(
                        function: () async {
                          if(cubit.registerNameController.text=="") {
                            ShowSnackBar(
                              context: context,
                              text: "Name mustn't be empty",
                            );
                          }
                          else  if(cubit.registerUserNameController.text=="") {
                            ShowSnackBar(
                              context: context,
                              text: "Username mustn't be empty",
                            );
                          } else  if(cubit.registerEmailController.text=="") {
                            ShowSnackBar(
                              context: context,
                              text: "Email mustn't be empty",
                            );
                          }else  if(cubit.registerPasswordController.text=="") {
                            ShowSnackBar(
                              context: context,
                              text: "Password mustn't be empty",
                            );
                          }else  if(cubit.registerConfirmPasswordController.text=="") {
                            ShowSnackBar(
                              context: context,
                              text: "Confirm Password mustn't be empty",
                            );
                          }
                          else if(cubit.registerPasswordController.text!=cubit.registerConfirmPasswordController.text) {
                            ShowSnackBar(
                              context: context,
                              text: "Password and Confirm Password fields doesn't match",
                            );
                          }
                          else{
                            bool isExistingUsername = await  cubit.auth.isUsernameExists(
                                cubit.registerUserNameController.text
                            );


                            if(isExistingUsername){
                              ShowSnackBar(
                                context: context,
                                text: "This username already exist",
                              );
                            }
                            else{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Completedata(false)));
                                }
                              }
                        },
                        text: 'Next',
                        isupper: false,
                        radius: 6,
                        background: buttonColor),

                    TextButton(
                      onPressed: (){Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>const LoginScreen()));} ,
                      child: const Text(
                        "Already have an Acounnt",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),

                    const Custom_Dividor(),
                    SizedBox(
                      height: getHeight(context, 50),
                    ),
                    SigninOption(
                      logo: AssetsRes.GOOGLE_LOGO,
                      background: googlebuttonColor,
                      width: w ,
                      height: getHeight(context, 50),
                      function: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=> const Completedata(true)));

                      },
                      radius: 6,
                    ),
                    SizedBox(
                      height: getHeight(context, 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    listener: (context,satate){});
  }
}




