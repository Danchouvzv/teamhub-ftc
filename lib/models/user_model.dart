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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'nickname': nickname,
      'role': role,
      'age': age,
      'country': country,
      'city': city,
      'avatarUrl': avatarUrl,
      'teamId': teamId,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      nickname: json['nickname'] as String?,
      role: json['role'] as String?,
      age: json['age'] as int?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      teamId: json['teamId'] as String?,
    );
  }

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

