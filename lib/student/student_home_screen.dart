
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/class.dart';
import '../providers/api_providers.dart';
import '../providers/id_provider.dart';

class StudentHomeScreen extends ConsumerWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentId = ref.watch(studentIdProvider);
    final classes = ref.watch(studentClassesProvider(studentId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: classes.when(
        data: (data) => _buildClassList(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildClassList(BuildContext context, List<Class> classes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classInfo = classes[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              classInfo.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            trailing: ElevatedButton(
              onPressed: () => context.go('/student/face_recognition/${classInfo.id}'),
              child: const Text('Mark Attendance'),
            ),
          ),
        );
      },
    );
  }
}
