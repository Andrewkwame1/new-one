import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/models/class.dart';
import 'package:myapp/providers/api_providers.dart';

class AddClassScreen extends ConsumerStatefulWidget {
  const AddClassScreen({super.key});

  @override
  ConsumerState<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends ConsumerState<AddClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _classNameController = TextEditingController();
  final List<String> _studentIds = [];

  void _addStudentIdField() {
    setState(() {
      _studentIds.add('');
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newClass = Class(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
        name: _classNameController.text,
        students: _studentIds.where((id) => id.isNotEmpty).toList(),
      );

      try {
        await ref.read(apiServiceProvider).addClass(newClass);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Class added successfully!')),
          );
          context.go('/teacher');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding class: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Class')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _classNameController,
                decoration: const InputDecoration(labelText: 'Class Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a class name' : null,
              ),
              const SizedBox(height: 20),
              const Text('Students', style: TextStyle(fontSize: 18)),
              ..._studentIds.asMap().entries.map((entry) {
                int index = entry.key;
                return TextFormField(
                  decoration: InputDecoration(labelText: 'Student ID ${index + 1}'),
                  onSaved: (value) => _studentIds[index] = value!,
                );
              }),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _addStudentIdField,
                icon: const Icon(Icons.add),
                label: const Text('Add Student'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Class'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
