abstract class TeamStates{}
class TeamInitialState extends TeamStates{}
class TeamshowVideoCallButtonState extends TeamStates{}
class TeamhideVideoCallButtonState extends TeamStates{}
class TeamUsingimageState extends TeamStates{}
class TeampickImageSuccessState extends TeamStates{}
class TeampickImagefaildState extends TeamStates{
  String error;
  TeampickImagefaildState(this.error);
}
class AddNewSkillsState extends TeamStates{}
class RemoveSkillsState extends TeamStates{}
class HideSkillsWidgetState extends TeamStates{}
class ShowSkillsWidgetState extends TeamStates{}
class SelectValueState extends TeamStates{}
class teamLoadUserDataStates extends TeamStates{}

class GetTeamDataLoadingStates extends TeamStates{}
class GetTeamDataSuccessStates extends TeamStates{}
class GetTeamDataFailStates extends TeamStates{
  String error;
  GetTeamDataFailStates(this.error){
    print("Error when get teams data : "+error);
  }
}class AddTeamDataLoadingStates extends TeamStates{}
class AddTeamDataSuccessStates extends TeamStates{}
class AddTeamDataFailStates extends TeamStates{
  late String error;
  AddTeamDataFailStates(this.error) {
    print("Error when adding new team : "+error);
  }
}
class selectDateState extends TeamStates{}
class selectTimeState extends TeamStates{}

class AddTaskSuccessState extends TeamStates{}
class AddTaskSFaildState extends TeamStates{
  String error;
  AddTaskSFaildState(this.error){
    print("Error when get teams data : "+error);
  }
}
class EditTaskSuccessState extends TeamStates{}
class EditTaskSFaildState extends TeamStates{
  String error;
  EditTaskSFaildState(this.error){
    print("Error when Edit Task data : "+error);
  }
}
class DeleteTaskSuccessState extends TeamStates{}
class DeleteTaskSFaildState extends TeamStates{
  String error;
  DeleteTaskSFaildState(this.error){
    print("Error when Delet Task data : "+error);
  }
}
class GetTaskLoadingState extends TeamStates{}
class GetTaskSuccessState extends TeamStates{}
class GetTaskSFaildState extends TeamStates{
  String error;
  GetTaskSFaildState(this.error){
    print("Error when get teams data : "+error);
  }
}

class UpdateStatusSuccessState extends TeamStates{}
class UpdateStatusFaildState extends TeamStates{
  String error;
  UpdateStatusFaildState(this.error){
    print("Error when update status : "+error);
  }
}