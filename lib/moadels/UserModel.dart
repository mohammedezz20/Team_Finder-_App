class UserModel {
  String name;
  String bio;
  String about;
  String email;
  String username;
  String photoURL;
  var links;
  var userStatus;
  var role;
  var id;

  UserModel({
    required this.name,
    required this.bio,
    required this.about,
    required this.email,
    required this.username,
    required this.photoURL,
    required this.links,
    this.role,
    this.userStatus,
  });

  UserModel.fromMap(Map<String, dynamic> map):
        name = map['name'],
  bio=map['bio'],
  about=map['about'],
        email = map['email'],
        username = map['username'],
        photoURL = map['photoURL'],
        role = map['role'],
        userStatus = map['userStatus'],
        links = map['links'];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'about': about,
      'email': email,
      'username': username,
      'photoURL': photoURL,
      'links': links,
      'role':role,
      'userStatus':userStatus,
    };
  }
}

class Links {
  var title;
  var link;
  Links({required this.title,required this.link});
  Links.fromMap(Map<String, dynamic> json)
      : title = json['title'],
        link = json['link'];


  Map<String, dynamic> toMap() {
    return {'title': title, 'link': link};
  }
}
