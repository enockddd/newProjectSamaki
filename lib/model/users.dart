class Users {
  final int? userId;
  final String? email;
  final String? username;
  final String? password;  // Added password field
  final String? userRole;
  final String? token;
  final String? phoneNumber;

  @override
  String toString() {
    return 'Users(userId: $userId, email: $email, username: $username, password: $password, userRole: $userRole, token: $token, phoneNumber: $phoneNumber)';
  }

  Users({
    this.userId,
    this.password, // password field made optional
    required this.email,
    required this.username,
    required this.userRole,
    this.token,
    required this.phoneNumber,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['user_id'] as int?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?, // Added password field
      userRole: json['user_role'] as String?,
      token: json['token'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'username': username,
      'password': password, // Added password field
      'user_role': userRole,
      'token': token,
      'phone_number': phoneNumber,
    };
  }
}
