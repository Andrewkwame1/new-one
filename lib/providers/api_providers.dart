
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/models/class.dart';
import 'package:myapp/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final teacherClassesProvider = FutureProvider.family<List<Class>, String>((ref, teacherId) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getTeacherClasses(teacherId);
});

final studentClassesProvider = FutureProvider.family<List<Class>, String>((ref, studentId) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getStudentClasses(studentId);
});
