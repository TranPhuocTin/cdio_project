class PageTeacherAttribute {
  final int totolElements;
  final int totalPages;
  final int size;

  PageTeacherAttribute({
    required this.totolElements,
    required this.totalPages,
    required this.size,
  });

  factory PageTeacherAttribute.fromJson(Map<String, dynamic> json) {
    return PageTeacherAttribute(
      totolElements: json['totalElements'],
      totalPages: json['totalPages'],
      size: json['size'],
    );
  }
}