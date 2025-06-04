class UserEntity {
  final String username;
  final String password;
  final String name;
  final String mobile;
  final String bdate;
  final double credits;
  final String email;

  UserEntity({
    required this.username,
    required this.password,
    required this.name,
    required this.mobile,
    required this.bdate,
    required this.credits,
    required this.email,
  });

  UserEntity copyWith({
    String? username,
    String? password,
    String? name,
    String? mobile,
    String? bdate,
    double? credits,
    String? email,
  }) {
    return UserEntity(
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      bdate: bdate ?? this.bdate,
      credits: credits ?? this.credits,
      email: email ?? this.email,
    );
  }
}
