import 'package:equatable/equatable.dart';

import '../../../data/models/user_model/models.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final UserModel user;
  final String password;

  const SignUpRequired(this.user, this.password);

  @override
  List<Object?> get props => [user, password];
}

class TogglePasswordVisibility extends SignUpEvent {}
