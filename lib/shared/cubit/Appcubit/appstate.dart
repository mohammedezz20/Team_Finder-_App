abstract class AppStates{}
class AppInitialState extends AppStates{}
class AppLoadUserDataStates extends AppStates{}
class ChoosePlatFormState extends AppStates{}
class AddlinkState extends AppStates{}
class RemovelinkState extends AppStates{}
class pickImageState extends AppStates{}
class pickImagefaildState extends AppStates{
  String error;
  pickImagefaildState(this.error){
    print(error);
  }
}
class UpdateImageState extends AppStates{}
class removeUpdateImageState extends AppStates{}

class UpdateProfileDataLoadingState extends AppStates{}
class UpdateProfileDataSuccessState extends AppStates{}
class UpdateProfileDataFaildState extends AppStates{
  String error;
  UpdateProfileDataFaildState(this.error);
}