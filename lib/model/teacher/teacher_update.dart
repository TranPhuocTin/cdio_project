class TeacherUpdate {
  int teacherId;
  String name;
  String dateOfBirth;
  String address;
  String phone;
  String email;
  int facultyId;
  int degreeId;
  String avatar;
  bool gender;
  dynamic accountId;

  TeacherUpdate({
    required this.teacherId,
    required this.name,
    required this.dateOfBirth,
    required this.address,
    required this.phone,
    required this.email,
    required this.facultyId,
    required this.degreeId,
    required this.avatar,
    required this.gender,
    required this.accountId,
  });

  factory TeacherUpdate.fromJson(Map<String, dynamic> json) {
    return TeacherUpdate(
      teacherId: json['teacherId'],
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      facultyId: json['facultyId'],
      degreeId: json['degreeId'],
      avatar: json['avatar'],
      gender: json['gender'],
      accountId: json['accountId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherId': teacherId,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'phone': phone,
      'email': email,
      'facultyId': facultyId,
      'degreeId': degreeId,
      'avatar': avatar,
      'gender': gender,
      'accountId': accountId,
    };
  }
}
