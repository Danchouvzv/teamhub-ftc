import 'package:equatable/equatable.dart';

class IdeaModel extends Equatable {
  final String id;
  final String teamId;
  final String authorId;
  final String title;
  final String description;
  final String category;
  final String status; // 'Предложена', 'В работе', 'Реализована'
  final List<String> voterIds;
  final DateTime createdAt;
  final DateTime? updatedAt;

  IdeaModel({
    required this.id,
    required this.teamId,
    required this.authorId,
    required this.title,
    required this.description,
    required this.category,
    this.status = 'Предложена',
    this.voterIds = const [],
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  int get voteCount => voterIds.length;

  @override
  List<Object?> get props => [
        id,
        teamId,
        authorId,
        title,
        description,
        category,
        status,
        voterIds,
        createdAt,
        updatedAt,
      ];
}

