
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/class.dart';
import '../providers/api_providers.dart';

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classes = ref.watch(teacherClassesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add_class'),
        child: const Icon(Icons.add),
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
            subtitle: Text('${classInfo.students.length} students'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.go('/teacher/class/${classInfo.id}'),
          ),
        );
      },
    );
  }
}
