import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model/models.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<UserModel> signUp(UserModel userModel, String password);

  Future<void> setUserData(UserModel userModel);

  Future<void> signIn(String email, password);

  Future<void> logOut();

  Future<void> uploadProfileImage(File image);
}
