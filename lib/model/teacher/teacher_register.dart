class TeacherRegister {
  final String name;
  final String dateOfBirth;
  final String address;
  final String phone;
  final String email;
  final int facultyId;
  final int degreeId;
  final String avatar;
  final bool gender;

  TeacherRegister({
    required this.name,
    required this.dateOfBirth,
    required this.address,
    required this.phone,
    required this.email,
    required this.facultyId,
    required this.degreeId,
    required this.avatar,
    required this.gender,
  });

  factory TeacherRegister.fromJson(Map<String, dynamic> json) {
    return TeacherRegister(
        name: json['name'],
        dateOfBirth: json['dateOfBirth'],
        address: json['address'],
        phone: json['phone'],
        email: json['email'],
        facultyId: json['facultyId'],
        degreeId: json['degreeId'],
        avatar: json['avatar'],
        gender: json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'dateOfBirth' : dateOfBirth,
      'address' : address,
      'phone' : phone,
      'email' : email,
      'facultyId' : facultyId,
      'degreeId' : degreeId,
      'avatar' : avatar,  
      'gender' : gender
    };
  }
} 
