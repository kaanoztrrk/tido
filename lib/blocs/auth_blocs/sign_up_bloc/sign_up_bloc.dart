import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../data/models/user_model/models.dart';
import '../../../data/repositories/user_repo.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;
  Timer? _timer;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>(_onSignUpRequired);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onSignUpRequired(
      SignUpRequired event, Emitter<SignUpState> emit) async {
    emit(SignUpProcess());
    try {
      UserModel user = await _userRepository.signUp(event.user, event.password);
      await _userRepository.setUserData(user);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure());
    }
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<SignUpState> emit) {
    final currentState = state;
    if (currentState is SignUpInitial) {
      emit(currentState.copyWith(
          obscurePassword: !currentState.obscurePassword));
    } else if (currentState is SignUpFailure) {
      emit(currentState.copyWith(
          obscurePassword: !currentState.obscurePassword));
    } else {
      emit(SignUpInitial(obscurePassword: true));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
