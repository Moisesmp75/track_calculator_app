class SignUpRequestModel {
  const SignUpRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.lastName,
    this.bornDate,
  });

  final String email;
  final String password;
  final String name;
  final String lastName;
  final String? bornDate;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'lastName': lastName,
        if (bornDate != null && bornDate!.isNotEmpty) 'bornDate': bornDate,
      };
}
