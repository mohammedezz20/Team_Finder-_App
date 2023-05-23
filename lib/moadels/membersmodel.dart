class Member {
  String uid;
  String role;

  Member({
    required this.uid,
    required this.role,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      uid: json['Uid'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Uid': uid,
      'role': role,
    };
  }
}
