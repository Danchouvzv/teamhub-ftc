import 'package:equatable/equatable.dart';

class TeamModel extends Equatable {
  final String id;
  final String name;
  final String? ftcNumber;
  final String country;
  final String city;
  final String? school;
  final String? description;
  final String? logoUrl;
  final String inviteCode;
  final String captainId;
  final List<String> memberIds;
  final DateTime createdAt;

  TeamModel({
    required this.id,
    required this.name,
    this.ftcNumber,
    required this.country,
    required this.city,
    this.school,
    this.description,
    this.logoUrl,
    this.inviteCode = '',
    required this.captainId,
    this.memberIds = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  List<Object?> get props => [
        id,
        name,
        ftcNumber,
        country,
        city,
        school,
        description,
        logoUrl,
        inviteCode,
        captainId,
        memberIds,
        createdAt,
      ];
}

