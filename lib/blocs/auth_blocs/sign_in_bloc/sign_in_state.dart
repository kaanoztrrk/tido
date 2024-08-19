import 'package:equatable/equatable.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInSuccess extends SignInState {}

final class SignInFailure extends SignInState {
  final String? message;

  const SignInFailure({this.message});

  @override
  List<Object?> get props => [message];
}

final class SignInProcess extends SignInState {}

final class SignOutSuccess extends SignInState {}

final class PasswordResetSuccess extends SignInState {}

// Profil bilgileri ile ilgili durumlar
class UserProfileLoaded extends SignInState {
  final String name;
  final String email;
  final String profileImageUrl;

  const UserProfileLoaded({
    required this.name,
    required this.email,
    required this.profileImageUrl,
  });

  @override
  List<Object?> get props => [name, email, profileImageUrl];
}

class UserProfileLoadFailure extends SignInState {
  final String message;

  const UserProfileLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileImageUploading extends SignInState {}

class ProfileImageUploadSuccess extends SignInState {}

class ProfileImageUploadFailure extends SignInState {
  final String message;

  const ProfileImageUploadFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileImageLoaded extends SignInState {
  final String? profileImageUrl;

  const ProfileImageLoaded({this.profileImageUrl});

  @override
  List<Object?> get props => [profileImageUrl];
}
