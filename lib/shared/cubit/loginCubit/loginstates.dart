

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class changePasswordVisibiltyState extends LoginStates{}
class pickImageState extends LoginStates{}
class pickImagefaildState extends LoginStates{ var error;

pickImagefaildState(this.error);

}
class Usingimagestate extends LoginStates{}
class ShowCvState extends LoginStates{}