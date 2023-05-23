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


// class User {
//   String name;
//   String bio;
//   String about;
//   String imageURL;
//   String cvLink;
//   List<String> links;
//   String email;
//   String password;

//   User({
//     this.name,
//     this.bio,
//     this.about,
//     this.imageURL,
//     this.cvLink,
//     this.links,
//     this.email,
//     this.password,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       name: json['name'],
//       bio: json['bio'],
//       about: json['about'],
//       imageURL: json['imageURL'],
//       cvLink: json['cvLink'],
//       links: List<String>.from(json['links']),
//       email: json['email'],
//       password: json['password'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'bio': bio,
//       'about': about,
//       'imageURL': imageURL,
//       'cvLink': cvLink,
//       'links': links,
//       'email': email,
//       'password': password,
//     };
//   }
// }