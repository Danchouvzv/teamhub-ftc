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

