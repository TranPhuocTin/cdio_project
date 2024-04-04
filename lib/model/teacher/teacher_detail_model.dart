class TeacherDetailModel {
  String name;
  String address;
  String avatar;
  String email;
  String phone;
  bool gender;
  DateTime dateOfBirth;
  int teacherId;
  int degreeId;
  int facultyId;

  TeacherDetailModel({
    required this.name,
    required this.address,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.teacherId,
    required this.degreeId,
    required this.facultyId,
  });

  factory TeacherDetailModel.fromJson(Map<String, dynamic> json) {
    return TeacherDetailModel(
      name: json['name'],
      address: json['address'],
      avatar: json['avatar'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      teacherId: json['teacherId'],
      degreeId: json['degreeId'],
      facultyId: json['facultyId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'avatar': avatar,
      'email': email,
      'phone': phone,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'teacherId': teacherId,
      'degreeId': degreeId,
      'facultyId': facultyId,
    };
  }
}
