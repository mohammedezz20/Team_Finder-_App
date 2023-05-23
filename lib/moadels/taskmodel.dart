class TaskModel {
  var taskTitle;
  var taskDetails;
  var startDate;
  var deadLine;
  var status;
  var taskID;

  TaskModel({
    required this.taskTitle,
    required this.taskDetails,
    required this.startDate,
    required this.deadLine,
    required this.status,
    this.taskID
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskTitle: json['taskTitle'],
      taskDetails: json['taskDetails'],
      startDate: json['startDate'],
      deadLine: json['deadLine'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskTitle': taskTitle,
      'taskDetails': taskDetails,
      'startDate': startDate,
      'deadLine': deadLine,
      'status': status,
    };
  }
}
