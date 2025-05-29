import 'package:in_between/features/registration/data/model/user_model.dart';

class UserEntity {
  final String userId;
  final String username;
  final String password;
  final String name;
  final String mobile;
  final String bdate;
  final double credits;

  UserEntity({
    required this.userId,
    required this.username,
    required this.password,
    required this.name,
    required this.mobile,
    required this.bdate,
    required this.credits,
  });
  UserModel toModel() {
    return UserModel(
      userId: userId,
      username: username,
      password: password,
      name: name,
      mobile: mobile,
      bdate: bdate,
      credits: credits,
    );
  }

  UserEntity copyWith({
    String? username,
    String? password,
    String? name,
    String? mobile,
    String? bdate,
    double? credits,
  }) {
    return UserEntity(
      userId: userId,
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      bdate: bdate ?? this.bdate,
      credits: credits ?? this.credits,
    );
  }
}


// class UserEntity {
//   final String? username;
//   final double credits;

//   UserEntity({required this.username, required this.credits});

//   UserEntity copyWith({String? username, double? credits}) {
//     return UserEntity(
//       username: username ?? this.username,
//       credits: credits ?? this.credits,
//     );
//   }
// }