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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ftcNumber': ftcNumber,
      'country': country,
      'city': city,
      'school': school,
      'description': description,
      'logoUrl': logoUrl,
      'inviteCode': inviteCode,
      'captainId': captainId,
      'memberIds': memberIds,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] as String,
      name: json['name'] as String,
      ftcNumber: json['ftcNumber'] as String?,
      country: json['country'] as String,
      city: json['city'] as String,
      school: json['school'] as String?,
      description: json['description'] as String?,
      logoUrl: json['logoUrl'] as String?,
      inviteCode: json['inviteCode'] as String? ?? '',
      captainId: json['captainId'] as String,
      memberIds: List<String>.from(json['memberIds'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

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

