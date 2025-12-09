import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? nickname;
  final String? role;
  final int? age;
  final String? country;
  final String? city;
  final String? avatarUrl;
  final String? teamId;

  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.nickname,
    this.role,
    this.age,
    this.country,
    this.city,
    this.avatarUrl,
    this.teamId,
  });

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        nickname,
        role,
        age,
        country,
        city,
        avatarUrl,
        teamId,
      ];
}

