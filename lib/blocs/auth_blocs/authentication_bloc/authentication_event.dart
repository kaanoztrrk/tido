import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User? user;

  const AuthenticationUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class DeleteUser extends AuthenticationEvent {
  final String? userId;
  const DeleteUser(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ChangePassword extends AuthenticationEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePassword(this.oldPassword, this.newPassword);

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
