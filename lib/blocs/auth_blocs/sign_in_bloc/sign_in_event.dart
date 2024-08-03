import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  const SignInRequired(this.email, this.password);
}

class SignOutRequired extends SignInEvent {
  const SignOutRequired();
}

class UploadProfileImage extends SignInEvent {
  final File imageFile;

  const UploadProfileImage(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class LoadUserProfileImage extends SignInEvent {}
