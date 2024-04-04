class StudentUpdate {
  final int studentId;
  final String name;
  final String dateOfBirth;
  final String address;
  final String phone;
  final String email;
  final String avatar;
  final bool gender;
  final int grade;

  StudentUpdate({
    required this.studentId,
    required this.name,
    required this.dateOfBirth,
    required this.address,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.grade,
  });

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'phone': phone,
      'email': email,
      'avatar': avatar,
      'gender': gender,
      'grade': grade,
    };
  }
}
