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
}

final class SignInProcess extends SignInState {}

final class SignOutSuccess extends SignInState {}

class ProfileImageUploading extends SignInState {}

class ProfileImageUploadSuccess extends SignInState {}

class ProfileImageUploadFailure extends SignInState {
  final String message;

  const ProfileImageUploadFailure(this.message);
}

class ProfileImageLoaded extends SignInState {
  final String? profileImageUrl;

  const ProfileImageLoaded({this.profileImageUrl});
}
