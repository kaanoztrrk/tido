import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown,
  deleting,
  error
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;
  final String? errorMessage;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
    this.errorMessage,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.deleting()
      : this._(status: AuthenticationStatus.deleting);

  const AuthenticationState.error(String message)
      : this._(status: AuthenticationStatus.error, errorMessage: message);

  @override
  List<Object?> get props => [status, user, errorMessage];
}
