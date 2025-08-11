import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
  }) : super(id: id, name: name, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle case where user info is inside `data`
    final map = (json['data'] is Map)
        ? Map<String, dynamic>.from(json['data'] as Map)
        : json;

    return UserModel(
      id: (map['_id'] ?? map['id'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
    );
  }
}
