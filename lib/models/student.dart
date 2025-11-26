class Student {
  final String id;
  final String name;
  // This is a placeholder for the face data. In a real application, you would
  // store a more robust representation of the face, such as a vector embedding.
  final List<double> faceData;

  Student({required this.id, required this.name, required this.faceData});

  factory Student.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Student(
      id: documentId,
      name: data['name'] as String,
      faceData: List<double>.from(data['faceData'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'faceData': faceData,
    };
  }
}
