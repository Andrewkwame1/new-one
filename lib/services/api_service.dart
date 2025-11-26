import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/class.dart';
import 'package:myapp/models/attendance_record.dart';

class ApiService {
  final String _baseUrl = 'http://10.0.2.2:8000/api'; // Replace with your backend URL

  Future<List<Class>> getClasses(String teacherId) async {
    final response = await http.get(Uri.parse('$_baseUrl/teachers/$teacherId/classes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Class.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }

  Future<void> addClass(Class newClass) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/classes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newClass.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add class');
    }
  }

  Future<void> markAttendance(String classId, String studentId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/classes/$classId/attendance'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'student_id': studentId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to mark attendance');
    }
  }

  Future<List<AttendanceRecord>> getAttendanceRecords(String classId) async {
    final response = await http.get(Uri.parse('$_baseUrl/classes/$classId/attendance'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => AttendanceRecord.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load attendance records');
    }
  }

  Future<List<Class>> getTeacherClasses() async {
    // TODO: Implement actual API call with teacher ID
    return Future.value([]);
  }

  Future<List<Class>> getStudentClasses() async {
    // TODO: Implement actual API call with student ID
    return Future.value([]);
  }
}
