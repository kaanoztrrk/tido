import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  final bool obscurePassword;
  final String? message;

  const SignUpState({this.obscurePassword = true, this.message});

  @override
  List<Object> get props => [obscurePassword, message ?? ''];

  SignUpState copyWith({bool? obscurePassword, String? message});
}

class SignUpInitial extends SignUpState {
  const SignUpInitial({super.obscurePassword});

  @override
  SignUpInitial copyWith({bool? obscurePassword, String? message}) {
    return SignUpInitial(
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

class SignUpProcess extends SignUpState {
  const SignUpProcess() : super();

  @override
  SignUpProcess copyWith({bool? obscurePassword, String? message}) {
    return const SignUpProcess();
  }
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess() : super();

  @override
  SignUpSuccess copyWith({bool? obscurePassword, String? message}) {
    return const SignUpSuccess();
  }
}

class SignUpFailure extends SignUpState {
  const SignUpFailure({super.message, super.obscurePassword});

  @override
  SignUpFailure copyWith({bool? obscurePassword, String? message}) {
    return SignUpFailure(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      message: message ?? this.message,
    );
  }
}
