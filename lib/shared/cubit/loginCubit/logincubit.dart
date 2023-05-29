import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Screens/authScreen.dart';
import '../../../main.dart';
import '../../../moadels/UserModel.dart';
import '../../../widget/ShowSnakebar.dart';
import '../../Network/remote/FireStoreMethod.dart';
import '../../Network/remote/FirebaseStorageMethod.dart';
import '../../Network/remote/auth_method.dart';
import 'loginstates.dart';

class Logincubit extends Cubit<LoginStates> {
  Logincubit() : super(LoginInitialState());
  static Logincubit obj(context) => BlocProvider.of(context);
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();
  var registerEmailController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerConfirmPasswordController = TextEditingController();
  var registerNameController = TextEditingController();
  var registerUserNameController = TextEditingController();
  var registerGithubController = TextEditingController();
  var registerLinkedInController = TextEditingController();
  var registerBioController = TextEditingController();
  var registerAboutController = TextEditingController();

  Auth auth = Auth();
  FirebaseStorageMethod firebaseStorageMethod = FirebaseStorageMethod();
  FireStoreMethod fireStoreMethod = FireStoreMethod();
  var showpassword = true;
  var icon = Icons.visibility_off_outlined;
  dynamic changpasswordstate() {
    showpassword = !showpassword;
    if (icon == Icons.visibility_off_outlined) {
      icon = Icons.visibility_outlined;
    } else {
      icon = Icons.visibility_off_outlined;
    }
    emit(changePasswordVisibiltyState());
  }

  bool useImage = false;
  usingimagestate() {
    useImage = !useImage;
    emit(Usingimagestate());
  }

  XFile imageFile = XFile("");
  File? file;
  Future<void> imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":
        imageFile = (await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 90,
        ))!;
        break;
      case "camera":
        imageFile = (await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 90,
        ))!;
        break;
    }

    if (imageFile != null) {
      file = File(imageFile.path);
      print("You selected image : ${imageFile.path}");
      emit(pickImageState());
    } else {
      print("You have not taken an image");
      emit(pickImagefaildState("You have not taken an image"));
    }

    Navigator.pop(context);
  }

  String file_path = '';
  select_file() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      final path = result.files.single.path!;
      return path;
    }
  }

  bool showcv = false;
  showcvstate() {
    showcv = !showcv;
    emit(ShowCvState());
  }

  register_with_email({
    required BuildContext context,
  }) async {
    emit(RegisterLoadingState());
   try  {
      if (registerBioController.text == '' ||
          registerAboutController.text == '' ||
          imageFile.toString() == defaultImagePath) {
        ShowSnackBar(
          context: context,
          text: "Make sure to Add the required data (Bio ,About and Image )",
        );
      } else {
        var photoURL = await firebaseStorageMethod.uploadImageToFirebase(file);
        var cvUrl = file_path == ''
            ? ''
            : await firebaseStorageMethod.uploadPDF(File(file_path));
        await auth.signUpWithEmail(
          email: registerEmailController.text,
          password: registerPasswordController.text,
          context: context,
          name: registerNameController.text,
          username: registerUserNameController.text,
          photoURL: photoURL,
          bio: registerBioController.text,
          about: registerAboutController.text,
          links: [
            Links(title: "cvURL", link: cvUrl).toMap(),
            Links(title: "gitHub", link: registerGithubController.text).toMap(),
            Links(title: "linkedIn", link: registerLinkedInController.text).toMap(),
          ],
        );
        loginAndregisterClearData();
        emit(RegisterStatusState());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
          (route) => false,
        );
      }
      
    }catch(error){
     emit(RegisterFaildState(error.toString()));
      print(error.toString());
    }
  }

  login_With_Email(context) async {
    emit(LoginLoadingState());
    try{
      if (loginEmailController.text == '' ||
          loginPasswordController.text == '') {
        ShowSnackBar(
          context: context,
          text: "Email and Password must not be empty",
        );
      } else {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email:  loginEmailController.text, password: loginPasswordController.text);

        loginAndregisterClearData();

      }    } on FirebaseAuthException catch (e) {
      emit(LoginFaildState(e.toString()));
      print(e.code.toString());
      if (e.code == 'user-not-found') {
        ShowSnackBar(
          context: context,
          text: 'No user found for : ${loginEmailController.text} .',
        );
      } else if (e.code == 'wrong-password') {
        ShowSnackBar(
          context: context,
          text: 'Wrong password provided for that user.',
        );
      } else if (e.code == 'invalid-email') {
        ShowSnackBar(
          context: context,
          text: 'Invalid email format',
        );
      }
    }
    emit(LoginStatusState());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
          (route) => false,
    );

  }

  register_with_Google({
    required BuildContext context,
    required bool isNew,
  }) async {
    try{
      if (!isNew) {
        auth.Sign_in_with_google(
            context: context,
            bio: registerBioController.text,
            about: registerAboutController.text,
            links: [
              Links(title: "cvURL", link: '').toMap(),
              Links(title: "gitHub", link: '').toMap(),
              Links(title: "linkedIn", link: '').toMap(),
            ],
            isnew: isNew);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AuthScreen()));
      } else {
        if (registerBioController.text == '' ||
            registerAboutController.text == '' ||
            imageFile == defaultImagePath) {
          ShowSnackBar(
            context: context,
            text: "Make sure to Add the required data (Bio ,About and Image )",
          );
        } else {
          var cvUrl = file_path == ''
              ? ''
              : firebaseStorageMethod.uploadPDF(File(file_path));
          auth.Sign_in_with_google(
                  context: context,
                  bio: registerBioController.text,
                  about: registerAboutController.text,
                  links: [
                    Links(title: "cvURL", link: cvUrl).toMap(),
                    Links(title: "gitHub", link: registerGithubController.text).toMap(),
                    Links(
                        title: "linkedIn",
                        link: registerLinkedInController.text).toMap(),
                  ],
                  isnew: isNew)
              .then((_) {
            fireStoreMethod.getUserData(auth.user!.uid);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AuthScreen()),
              (route) => false,
            );
          });
        }
      }

    }catch(error){
      print(error.toString());
    }
    loginAndregisterClearData();
  }
    loginAndregisterClearData(){
    loginPasswordController.clear();
    loginEmailController.clear();
    registerNameController.clear();
    registerUserNameController.clear();
    registerBioController.clear();
    registerAboutController.clear();
    registerEmailController.clear();
    registerLinkedInController.clear();
    registerGithubController.clear();
    registerConfirmPasswordController.clear();
    registerPasswordController.clear();
    }

}
