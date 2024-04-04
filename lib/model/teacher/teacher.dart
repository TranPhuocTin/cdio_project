class Teacher {
  final int teacherId;
  final String facultyName;
  final String avatar;
  final String email;
  final String phone;
  final String teacherName;

  Teacher({
    required this.teacherId,
    required this.facultyName,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.teacherName,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        teacherId: json['teacherId'] ?? 0,
        facultyName: json['facultyName'] ?? '',
        avatar: json['avatar'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        teacherName: json['teacherName'] ?? '');
  }
}
