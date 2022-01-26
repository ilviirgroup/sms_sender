class User {
  final int id;
  final String code;
  final String phone;

  User({
    required this.id,
    required this.code,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['pk'],
        code: json['code_generator'],
        phone: json['user_number'],
      );
}
