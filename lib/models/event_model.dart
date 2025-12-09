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

