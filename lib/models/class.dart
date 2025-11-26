class Class {
  final String id;
  final String name;
  final List<String> students;

  Class({required this.id, required this.name, required this.students});

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      students: List<String>.from(json['students']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'students': students};
  }
}
