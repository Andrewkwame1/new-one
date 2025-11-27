class Class {
  final String id;
  final String name;
  final String teacherId;
  final List<String> students;

  Class({required this.id, required this.name, required this.teacherId, required this.students});

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      teacherId: json['teacherId'],
      students: List<String>.from(json['students']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teacherId': teacherId,
      'students': students,
    };
  }
}
