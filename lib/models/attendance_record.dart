class AttendanceRecord {
  final String id;
  final String studentId;
  final String classId;
  final DateTime timestamp;

  AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.classId,
    required this.timestamp,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      studentId: json['studentId'],
      classId: json['classId'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'classId': classId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
