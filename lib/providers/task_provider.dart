import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'auth_provider.dart';

/// Provider для задач проекта
final projectTasksProvider = StreamProvider.family<List<Task>, String>((ref, projectId) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getProjectTasks(projectId);
});

/// Provider для задач текущего пользователя
final userTasksProvider = StreamProvider<List<Task>>((ref) async* {
  final user = ref.watch(currentFirebaseUserProvider);
  if (user == null) {
    yield [];
    return;
  }

  // TODO: Implement query for user's assigned tasks
  // For now, returning empty list
  yield [];
});

/// Provider для создания задачи
final createTaskProvider = Provider<Future<void> Function(Task task)>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return (Task task) async {
    await firestoreService.createTask(task);
  };
});

/// Provider для обновления задачи
final updateTaskProvider = Provider<Future<void> Function(String taskId, Map<String, dynamic> data)>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return (String taskId, Map<String, dynamic> data) async {
    await firestoreService.updateTask(taskId, data);
  };
});

