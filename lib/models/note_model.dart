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

