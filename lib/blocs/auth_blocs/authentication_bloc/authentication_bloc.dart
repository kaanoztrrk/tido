import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import '../../../data/repositories/user_repo.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({
    required this.userRepository,
  }) : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });

    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<DeleteUser>(_onDeleteUser);
    on<ChangePassword>(_onChangePassword);
  }

  void _onAuthenticationUserChanged(
      AuthenticationUserChanged event, Emitter<AuthenticationState> emit) {
    if (event.user != null) {
      emit(AuthenticationState.authenticated(event.user!));
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<void> _onDeleteUser(
      DeleteUser event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.deleting());
    try {
      await userRepository.deleteUser();

      await Hive.deleteFromDisk();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(const AuthenticationState.unauthenticated());

      SystemNavigator.pop();
    } catch (e) {
      print('Error deleting user: $e');
      emit(AuthenticationState.error(e.toString()));
    }
  }

  Future<void> _onChangePassword(
      ChangePassword event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationState.deleting());
    try {
      await userRepository.changePassword(event.oldPassword, event.newPassword);
      emit(AuthenticationState.authenticated(
          FirebaseAuth.instance.currentUser!));
    } catch (e) {
      print('Error changing password: $e');
      emit(AuthenticationState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
