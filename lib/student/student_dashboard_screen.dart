import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  final _studentIdController = TextEditingController();

  @override
  void dispose() {
    _studentIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _studentIdController,
              decoration: const InputDecoration(
                labelText: 'Enter Your Student ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                final studentId = _studentIdController.text;
                if (studentId.isNotEmpty) {
                  context.go('/scan-qr?studentId=$studentId');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter your Student ID'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan QR Code for Attendance'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final studentId = _studentIdController.text;
                if (studentId.isNotEmpty) {
                  // Hardcoded classId for now, will be replaced with a dynamic way to select a class
                  const classId = 'your-class-id';
                  context.go(
                      '/student/attendance-history/$classId/$studentId');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter your Student ID'),
                    ),
                  );
                }
              },
              child: const Text('View Attendance History'),
            ),
          ],
        ),
      ),
    );
  }
}
