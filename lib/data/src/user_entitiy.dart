import 'package:equatable/equatable.dart';

class UserModelEntity extends Equatable {
  final String userId;
  final String email;
  final String name;
  final bool hasAdsRemoved;
  final bool hasExtraFeatures;
  final bool hasFullAccess;

  const UserModelEntity({
    required this.userId,
    required this.email,
    required this.name,
    this.hasAdsRemoved = false,
    this.hasExtraFeatures = false,
    this.hasFullAccess = false,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'hasAdsRemoved': hasAdsRemoved,
      'hasExtraFeatures': hasExtraFeatures,
      'hasFullAccess': hasFullAccess,
    };
  }

  static UserModelEntity fromDocument(Map<String, dynamic> doc) {
    return UserModelEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      hasAdsRemoved: doc['hasAdsRemoved'] ?? false,
      hasExtraFeatures: doc['hasExtraFeatures'] ?? false,
      hasFullAccess: doc['hasFullAccess'] ?? false,
    );
  }

  @override
  List<Object?> get props =>
      [userId, email, name, hasAdsRemoved, hasExtraFeatures, hasFullAccess];
}
