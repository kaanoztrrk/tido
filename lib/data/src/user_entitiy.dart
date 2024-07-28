import 'package:equatable/equatable.dart';

class UserModelEntity extends Equatable {
  final String userId;
  final String email;
  final String name;

  const UserModelEntity({
    required this.userId,
    required this.email,
    required this.name,
  });

  Map<String, Object?> toDocument() {
    return {'userId': userId, 'email': email, 'name': name};
  }

  static UserModelEntity fromDocument(Map<String, dynamic> doc) {
    return UserModelEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
    );
  }

  @override
  List<Object?> get props => [userId, email, name];
}
