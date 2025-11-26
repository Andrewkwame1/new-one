
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/models/class.dart';
import 'package:myapp/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final teacherClassesProvider = FutureProvider<List<Class>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getTeacherClasses();
});

final studentClassesProvider = FutureProvider<List<Class>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.getStudentClasses();
});
