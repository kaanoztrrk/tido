import '../../src/user_entitiy.dart';

class UserModel {
  final String userId;
  final String email;
  final String name;
  final bool hasAdsRemoved;
  final bool hasExtraFeatures;
  final bool hasFullAccess;

  const UserModel({
    required this.userId,
    required this.email,
    required this.name,
    this.hasAdsRemoved = false,
    this.hasExtraFeatures = false,
    this.hasFullAccess = false,
  });

  static const empty = UserModel(
    userId: '',
    email: '',
    name: '',
  );

  UserModel copyWith({
    String? userId,
    String? email,
    String? name,
    bool? hasAdsRemoved,
    bool? hasExtraFeatures,
    bool? hasFullAccess,
    required profileImageUrl,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      hasAdsRemoved: hasAdsRemoved ?? this.hasAdsRemoved,
      hasExtraFeatures: hasExtraFeatures ?? this.hasExtraFeatures,
      hasFullAccess: hasFullAccess ?? this.hasFullAccess,
    );
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
      hasAdsRemoved: false,
      hasExtraFeatures: false,
      hasFullAccess: false,
    );
  }

  List<Object?> get props =>
      [userId, email, name, hasAdsRemoved, hasExtraFeatures, hasFullAccess];
}
