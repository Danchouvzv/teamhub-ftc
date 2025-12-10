import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String id;
  final String teamId;
  final String? projectId;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime? endTime;
  final String? location;
  final String type; // 'Соревнование', 'Дедлайн', 'Тест', 'Встреча'
  final bool isPersonal;
  final String? userId;

  EventModel({
    required this.id,
    required this.teamId,
    this.projectId,
    required this.title,
    this.description,
    DateTime? startTime,
    this.endTime,
    this.location,
    required this.type,
    this.isPersonal = false,
    this.userId,
  }) : startTime = startTime ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'projectId': projectId,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'location': location,
      'type': type,
      'isPersonal': isPersonal,
      'userId': userId,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      projectId: json['projectId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
      location: json['location'] as String?,
      type: json['type'] as String,
      isPersonal: json['isPersonal'] as bool? ?? false,
      userId: json['userId'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        teamId,
        projectId,
        title,
        description,
        startTime,
        endTime,
        location,
        type,
        isPersonal,
        userId,
      ];
}

