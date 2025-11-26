import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClassDetailPage extends StatelessWidget {
  final String classId;

  const ClassDetailPage({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class ID: $classId',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/teacher/class_attendance/$classId');
              },
              child: const Text('View Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
