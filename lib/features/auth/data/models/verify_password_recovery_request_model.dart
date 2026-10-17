class VerifyPasswordRecoveryRequestModel {
  const VerifyPasswordRecoveryRequestModel({
    required this.email,
    required this.name,
    required this.lastName,
    required this.bornDate,
  });

  final String email;
  final String name;
  final String lastName;
  final String bornDate;

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'lastName': lastName,
        'bornDate': bornDate,
      };
}
