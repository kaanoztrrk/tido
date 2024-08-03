import '../../src/user_entitiy.dart';

class UserModel {
  final String userId;
  final String email;
  final String name;

  const UserModel({
    required this.userId,
    required this.email,
    required this.name,
  });

  static const empty = UserModel(userId: '', email: '', name: '');

  UserModel copyWith({
    String? userId,
    String? email,
    String? name,
    required profileImageUrl,
  }) {
    return UserModel(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name);
  }

  UserModelEntity toEntity() {
    return UserModelEntity(
      userId: userId,
      email: email,
      name: name,
    );
  }

  static UserModel fromEntity(UserModelEntity entity) {
    return UserModel(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
    );
  }

  List<Object?> get props => [userId, email, name];
}
