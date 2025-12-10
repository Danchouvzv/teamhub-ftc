import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  final String id;
  final String teamId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ProjectModel({
    required this.id,
    required this.teamId,
    required this.name,
    this.description,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        teamId,
        name,
        description,
        createdAt,
        updatedAt,
      ];
}

