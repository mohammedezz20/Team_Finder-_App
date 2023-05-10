import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Screens/authScreen.dart';
import '../../../widget/ShowSnakebar.dart';
import '../../Network/FireStoreMethod.dart';
import '../../Network/FirebaseStorageMethod.dart';
import '../../Network/auth_method.dart';
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
  var registerGithubNameController = TextEditingController();
  var registerLinkedInNameController = TextEditingController();

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

    if (registerGithubNameController.text == '' ||
        registerLinkedInNameController.text == '' ||
        file_path == '') {
      ShowSnackBar(
        context: context,
        text:
        "Make sure to type the required data (Github ,LinkedIn and CV )",
      );}
     else {
        var photoURL = firebaseStorageMethod.uploadImageToFirebase(file);
        var cvUrl = firebaseStorageMethod.uploadPDF(File(file_path));
        auth.signUpWithEmail(
            email: registerEmailController.text,
            password: registerPasswordController.text,
            context: context,
            name: registerNameController.text,
            username: registerUserNameController.text,
            githubLink: registerGithubNameController.text,
            linkedinLink: registerLinkedInNameController.text,
            photoURL: photoURL,
            cV_URL: cvUrl);
        registerEmailController.text = '';
        registerPasswordController.text = '';
        registerNameController.text = '';
        registerUserNameController.text = '';
        registerConfirmPasswordController.text = '';
        registerLinkedInNameController.text = '';
        registerGithubNameController.text = '';
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AuthScreen()));
      }
  }

  login_With_Email(context){
    if(loginEmailController.text==''||loginPasswordController.text=='')
      {
        ShowSnackBar(
          context: context,
          text:
          "Email and Password must not be empty",
        );
      }
    else{
      auth.Sign_in_with_EmailAndPassword(
          emailAddress: loginEmailController.text,
          password: loginPasswordController.text,
          context: context);
    }
  }

  register_with_Google({
    required BuildContext context,
    required bool isNew,
  }) async {
    if (!isNew) {
      var cvUrl = firebaseStorageMethod.uploadPDF(File(file_path));
      auth.Sign_in_with_google(
          context: context,
          githubLink: registerGithubNameController.text,
          linkedinLink: registerLinkedInNameController.text,
          cV_URL: cvUrl,
          isnew: isNew);
      registerLinkedInNameController.text = '';
      registerGithubNameController.text = '';
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthScreen()));
    } else {
      if (registerGithubNameController.text == '' ||
          registerLinkedInNameController.text == '' ||
          file_path == '') {
        ShowSnackBar(
          context: context,
          text:
              "Make sure to type the required data (Github ,LinkedIn and CV )",
        );
      } else {
        var cvUrl = firebaseStorageMethod.uploadPDF(File(file_path));
        auth.Sign_in_with_google(
            context: context,
            githubLink: registerGithubNameController.text,
            linkedinLink: registerLinkedInNameController.text,
            cV_URL: cvUrl,
            isnew: isNew).then((_){
          fireStoreMethod.getUserData(auth.user!.uid);
          registerLinkedInNameController.text = '';
          registerGithubNameController.text = '';
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const AuthScreen()));
        });

      }
    }
  }
}
