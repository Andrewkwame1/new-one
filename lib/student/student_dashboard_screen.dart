import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/api_providers.dart';
import '../providers/id_provider.dart';

class StudentDashboardScreen extends ConsumerWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentId = ref.watch(studentIdProvider);
    final classesAsyncValue = ref.watch(studentClassesProvider(studentId));

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Your Classes",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: classesAsyncValue.when(
                data: (classes) {
                  if (classes.isEmpty) {
                    return const Center(
                      child: Text("You are not enrolled in any classes."),
                    );
                  }
                  return ListView.builder(
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      final classInfo = classes[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(classInfo.name),
                          subtitle: Text("Class ID: ${classInfo.id}"),
                          trailing: ElevatedButton(
                            onPressed: () {
                              context.go(
                                  '/student/attendance-history/${classInfo.id}/$studentId');
                            },
                            child: const Text('View History'),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text("Error loading classes: $error"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                context.go('/scan-qr?studentId=$studentId');
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan QR Code for Attendance'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
