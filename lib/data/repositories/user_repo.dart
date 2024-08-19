import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model/models.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<UserModel> signUp(UserModel userModel, String password);

  Future<void> setUserData(UserModel userModel);

  Future<void> signIn(String email, String password);

  Future<void> logOut();

  Future<void> uploadProfileImage(File image);

  Future<void> signInWithGoogle();

  Future<void> deleteUser();

  Future<void> changePassword(String oldPassword, String newPassword);

  Future<void> resetPassword(String email);
}
