import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/models/attendance_record.dart';
import 'package:myapp/providers/api_providers.dart';

class ClassAttendanceScreen extends ConsumerWidget {
  final String classId;

  const ClassAttendanceScreen({super.key, required this.classId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiService = ref.watch(apiServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Records')),
      body: FutureBuilder<List<AttendanceRecord>>(
        future: apiService.getAttendanceRecords(classId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No attendance records found.'));
          } else {
            final records = snapshot.data!;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return ListTile(
                  title: Text('Student ID: ${record.studentId}'),
                  subtitle: Text('Time: ${record.timestamp}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
