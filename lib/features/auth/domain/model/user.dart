class User {
  const User({
    required this.email,
    required this.name,
    required this.lastName,
    required this.bornDate,
  });

  final String email;
  final String name;
  final String lastName;
  final String bornDate;

  String get fullName => '$name $lastName';
}
