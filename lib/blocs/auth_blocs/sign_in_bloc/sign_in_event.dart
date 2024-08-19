import 'dart:io';

abstract class SignInEvent {}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  SignInRequired({required this.email, required this.password});
}

class SignOutRequired extends SignInEvent {}

class UploadProfileImage extends SignInEvent {
  final File imageFile;

  UploadProfileImage({required this.imageFile});
}

class LoadUserProfileImage extends SignInEvent {}

class GoogleSignInRequired extends SignInEvent {}

class ForgotPasswordRequired extends SignInEvent {
  final String email;

  ForgotPasswordRequired({required this.email});
}

class LoadUserProfile extends SignInEvent {}
