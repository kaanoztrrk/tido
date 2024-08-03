import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import '../models/user_model/models.dart';
import 'user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('user');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp(UserModel userModel, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );

      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Update the user's displayName
        await firebaseUser.updateProfile(displayName: userModel.name);
        await firebaseUser.reload();
        firebaseUser = _firebaseAuth.currentUser;

        userModel = userModel.copyWith(
            userId: firebaseUser!.uid, profileImageUrl: null);
        // Set user data in Firestore
        await setUserData(userModel);

        return userModel;
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(UserModel userModel) async {
    try {
      await userCollection
          .doc(userModel.userId)
          .set(userModel.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> uploadProfileImage(File image) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final fileName = path.basename(image.path);
        final uploadTask = storageRef
            .child('profile_images/${user.uid}/$fileName')
            .putFile(image);
        final snapshot = await uploadTask.whenComplete(() => {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        await userCollection
            .doc(user.uid)
            .update({'profileImageUrl': downloadUrl});
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
