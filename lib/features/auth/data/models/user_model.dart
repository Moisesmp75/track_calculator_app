class UserModel {
  const UserModel({
    required this.email,
    required this.name,
    required this.lastName,
    required this.bornDate,
  });

  final String email;
  final String name;
  final String lastName;
  final String bornDate;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: (json['email'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      lastName: (json['lastName'] as String?) ?? '',
      bornDate: (json['bornDate'] as String?) ?? '',
    );
  }
}
