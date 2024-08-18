import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model/models.dart';
import 'user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('user');
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<UserCredential> signInWithGoogle() async {
    try {
      // 1. Google ile giriş yapma
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google kullanıcı girişi başarısız.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 2. Firebase ile kimlik doğrulama
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = userCollection.doc(user.uid);
        final userDocSnapshot = await userDoc.get();

        // 3. Kullanıcı verilerini Firestore'a kaydetme
        if (!userDocSnapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName,
            'photoURL': user.photoURL,
            // Diğer kullanıcı bilgilerini buraya ekleyebilirsiniz
          });
        }
      } else {
        throw Exception('Firebase kullanıcı kimliği doğrulama başarısız.');
      }

      return userCredential;
    } catch (e) {
      log('Google ile giriş yaparken hata oluştu: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      try {
        // 1. Delete user data from Firestore
        await userCollection.doc(user.uid).delete();

        // 2. Delete user from Firebase Authentication
        await user.delete();

        // 3. Delete user images from Firebase Storage
        final storage = FirebaseStorage.instance;
        final imageRef = storage.ref().child('profile_images/${user.uid}');
        final ListResult result = await imageRef.listAll();
        for (var item in result.items) {
          await item.delete(); // Delete each image
        }

        // 4. Delete user data from Hive
        await Hive.deleteFromDisk();

        // 5. Clear SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Optionally: handle additional cleanup if needed
      } catch (e) {
        print('Error deleting user: $e');
        throw Exception('Error deleting user: $e');
      }
    } else {
      throw Exception('No user is currently signed in.');
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      try {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );

        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
      } catch (e) {
        throw Exception('Error changing password: $e');
      }
    } else {
      throw Exception('No user is currently signed in.');
    }
  }
}
