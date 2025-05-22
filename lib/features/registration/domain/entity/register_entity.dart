class Registration {
  final String username;
  final String password;
  final String name;
  final String mobile;
  final String bdate;
  double credit;

  Registration({
    required this.username,
    required this.password,
    required this.name,
    required this.mobile,
    required this.bdate,
    this.credit = 0,
  });
}

//not in use UserEntity gamit ko
