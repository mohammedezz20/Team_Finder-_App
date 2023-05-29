import 'membersmodel.dart';

class TeamModel {
 var teamID;
  String teamName;
  String teamDescription;
  String teamCategory;
  List<String> requiredSkills;
  String logoURL;
  String creationDate;
  List<Member> members;
  var role;

  TeamModel({
    required this.teamName,
    required this.teamDescription,
    required this.teamCategory,
    required this.requiredSkills,
    required this.logoURL,
    required this.creationDate,
    required this.members,
    this.teamID,
    this.role
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      teamName: json['teamName'],
      teamDescription: json['teamDescription'],
      teamCategory: json['teamCategory'],
      requiredSkills: List<String>.from(json['requiredSkills']),
      logoURL: json['logoURL'],
      creationDate: json['creationDate'],
      members: List<Member>.from(json['membersID'].map((member) => Member.fromJson(member))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'teamDescription': teamDescription,
      'teamCategory': teamCategory,
      'requiredSkills': requiredSkills,
      'logoURL': logoURL,
      'creationDate': creationDate,
      'membersID': members.map((member) => member.toJson()).toList(),
    };
  }
}
