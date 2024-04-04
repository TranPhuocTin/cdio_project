class ChangePassword {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePassword({this.oldPassword, this.newPassword, this.confirmPassword});

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword
    };
  }
}
