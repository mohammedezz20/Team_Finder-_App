class UserModel {
  String email;
  String name;
  String username;
  String githubLink;
  String linkedinLink;
  String photoURL;
  String cV_URL;

  UserModel({
    required this.email,
    required this.name,
    required this.username,
    required this.githubLink,
    required this.linkedinLink,
    required this.photoURL,
    required this.cV_URL,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : email = map['email'],
        name = map['name'],
        username = map['username'],
        githubLink = map['githubLink'],
        linkedinLink = map['linkedinLink'],
        photoURL = map['photoURL'],
        cV_URL = map['cv_URL'];

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'githubLink': githubLink,
      'linkedinLink': linkedinLink,
      'photoURL': photoURL,
      'cv_URL': cV_URL,
    };
  }
}
