

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class changePasswordVisibiltyState extends LoginStates{}
class pickImageState extends LoginStates{}
class pickImagefaildState extends LoginStates{ var error;

pickImagefaildState(this.error);

}
class Usingimagestate extends LoginStates{}
class ShowCvState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginStatusState extends LoginStates{}
class LoginFaildState extends LoginStates{
  String error;
  LoginFaildState(this.error){
    print("error When Login : $error"  );
  }

}
class RegisterLoadingState extends LoginStates{}
class RegisterStatusState extends LoginStates{}
class RegisterFaildState extends LoginStates {
  String error;

  RegisterFaildState(this.error) {
    print("error When Login : $error");
  }
}