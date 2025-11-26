import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentAttendanceHistoryScreen extends StatelessWidget {
  final String classId;
  final String studentId;

  const StudentAttendanceHistoryScreen(
      {super.key, required this.classId, required this.studentId});

  Future<int> _getAttendanceCount() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('classes')
        .doc(classId)
        .collection('attendance')
        .where('studentId', isEqualTo: studentId)
        .get();

    return snapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
      ),
      body: FutureBuilder<int>(
        future: _getAttendanceCount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No attendance records yet.'));
          }

          return Center(
            child: Text(
              'You have attended this class ${snapshot.data} times.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        },
      ),
    );
  }
}
