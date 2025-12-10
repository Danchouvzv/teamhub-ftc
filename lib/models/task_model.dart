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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'listId': listId,
      'title': title,
      'description': description,
      'projectName': projectName,
      'assigneeIds': assigneeIds,
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority.name,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      listId: json['listId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      projectName: json['projectName'] as String?,
      assigneeIds: List<String>.from(json['assigneeIds'] ?? []),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TaskPriority.medium,
      ),
      status: TaskStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TaskStatus.open,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

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

