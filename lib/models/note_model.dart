import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String id;
  final String projectId;
  final String? parentId;
  final String title;
  final String? content;
  final List<String> tags;
  final List<String> attachmentUrls;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoteModel({
    required this.id,
    required this.projectId,
    this.parentId,
    required this.title,
    this.content,
    this.tags = const [],
    this.attachmentUrls = const [],
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'parentId': parentId,
      'title': title,
      'content': content,
      'tags': tags,
      'attachmentUrls': attachmentUrls,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      parentId: json['parentId'] as String?,
      title: json['title'] as String,
      content: json['content'] as String?,
      tags: List<String>.from(json['tags'] ?? []),
      attachmentUrls: List<String>.from(json['attachmentUrls'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        projectId,
        parentId,
        title,
        content,
        tags,
        attachmentUrls,
        createdAt,
        updatedAt,
      ];
}

