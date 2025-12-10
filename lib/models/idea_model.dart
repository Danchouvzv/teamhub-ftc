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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'authorId': authorId,
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'voterIds': voterIds,
      'votes': voterIds, // Для совместимости с firestore_service
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    // Поддержка обоих форматов: voterIds и votes
    final voters = json['voterIds'] as List? ?? json['votes'] as List? ?? [];
    
    return IdeaModel(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      authorId: json['authorId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      status: json['status'] as String? ?? 'Предложена',
      voterIds: List<String>.from(voters),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

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

