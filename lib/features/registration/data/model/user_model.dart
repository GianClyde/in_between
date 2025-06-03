import 'dart:convert';

import 'package:in_between/core/domain/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userId,
    required super.username,
    required super.password,
    required super.name,
    required super.mobile,
    required super.bdate,
    required super.credits,
  });

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      username: username,
      password: password,
      name: name,
      mobile: mobile,
      bdate: bdate,
      credits: credits,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'password': password,
      'name': name,
      'mobile': mobile,
      'bdate': bdate,
      'credit': credits,
      'type': "user",
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      mobile: map['mobile'] as String,
      bdate: map['bdate'] as String,
      credits: map['credit'] as double, // Changed from 'credits' to 'credit'
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  UserModel copyWith({
    String? username,
    String? password,
    String? name,
    String? mobile,
    String? bdate,
    double? credits,
  }) {
    return UserModel(
      userId: userId,
      name: name ?? this.name,
      username: username ?? this.username,
      mobile: mobile ?? this.mobile,
      bdate: bdate ?? this.bdate,
      password: password ?? this.password,
      credits: credits ?? 0.0,
    );
  }
}
