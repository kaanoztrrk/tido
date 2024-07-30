import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/repositories/user_repo.dart';

import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  Timer? _timer;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>(_onSignInRequired);
    on<SignOutRequired>(_onSignOutRequired);
  }

  Future<void> _onSignInRequired(
      SignInRequired event, Emitter<SignInState> emit) async {
    emit(SignInProcess());
    try {
      await _userRepository.signIn(event.email, event.password);
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignInFailure(message: e.code));
    } catch (e) {
      emit(const SignInFailure());
    }
  }

  Future<void> _onSignOutRequired(
      SignOutRequired event, Emitter<SignInState> emit) async {
    await _userRepository.logOut();
    emit(SignOutSuccess());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
