import 'package:advanced_project/Screens/Register.dart';
import 'package:advanced_project/res/assets_res.dart';
import 'package:advanced_project/shared/cubit/loginCubit/logincubit.dart';
import 'package:advanced_project/shared/cubit/loginCubit/loginstates.dart';
import 'package:advanced_project/SizeCalc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/Colors.dart';
import '../widget/Button.dart';
import '../widget/Separator.dart';
import '../widget/Signinoption.dart';
import '../widget/text_Field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return BlocConsumer<Logincubit,LoginStates>(
        builder: (context,state){
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
                          "Login",
                          style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: getHeight(context, 50),
                        ),
                        DefaultTextField(
                          controller: cubit.loginEmailController,
                          text: "Email",
                          suffixIcon: null,
                          ispass: false,
                          suffixpressed: () {},
                          hint: "Enter your ُEmail",
                        ),
                        SizedBox(
                          height: getHeight(context, 30),
                        ),
                        DefaultTextField(
                          controller: cubit.loginPasswordController,
                          text: "Password",
                          suffixIcon: cubit.icon,
                          ispass: cubit.showpassword,
                          suffixpressed: (){cubit.changpasswordstate();},
                          hint: "***************",
                        ),
                  SizedBox(height: getHeight(context, 30),),
                        defaultButton(
                            function: () {
                              cubit.login_With_Email(context);

                            },
                            text: 'Login',
                            isupper: false,
                            radius: 6,
                            background: buttonColor),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have account? ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                              onPressed: (){Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>const RegisterScreen()));} ,
                              child: const Text(
                                "Create now",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                        const Custom_Dividor(),
                        SizedBox(
                          height: getHeight(context, 50),
                        ),
                        SigninOption(
                          logo: AssetsRes.GOOGLE_LOGO,
                          background: googlebuttonColor,
                          width: w ,
                          height: getHeight(context,50 ),
                          function: () {
                            cubit.register_with_Google(context: context, isNew: false);
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
        listener: (context,state){});
  }
}


