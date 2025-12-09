import 'package:equatable/equatable.dart';

enum TaskPriority { low, medium, high }
enum TaskStatus { open, inProgress, completed }

class Task extends Equatable {
  final String id;
  final String projectId;
  final String? listId;
  final String title;
  final String? description;
  final String? projectName;
  final List<String> assigneeIds;
  final DateTime? dueDate;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Task({
    required this.id,
    required this.projectId,
    this.listId,
    required this.title,
    this.description,
    this.projectName,
    this.assigneeIds = const [],
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.open,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  List<Object?> get props => [
        id,
        projectId,
        listId,
        title,
        description,
        projectName,
        assigneeIds,
        dueDate,
        priority,
        status,
        createdAt,
        updatedAt,
      ];
}

// Keep backward compatibility
typedef TaskModel = Task;

