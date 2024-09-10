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

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
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

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = userCollection.doc(user.uid);
        final userDocSnapshot = await userDoc.get();

        if (!userDocSnapshot.exists) {
          await userDoc.set({
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName,
            'photoURL': user.photoURL,
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

    if (user == null) {
      throw Exception('No user is currently signed in.');
    }

    try {
      final uid = user.uid;

      // 1. Kullanıcı verilerini Firestore'dan sil
      await userCollection.doc(uid).delete();

      // 2. Kullanıcıyı Firebase Authentication'dan sil
      await user.delete();

      // 3. Kullanıcının Firebase Storage'daki profil resimlerini sil
      final storage = FirebaseStorage.instance;
      final imageRef = storage.ref().child('profile_images/$uid');
      final ListResult result = await imageRef.listAll();
      for (var item in result.items) {
        await item.delete(); // Her bir resmi sil
      }

      // 4. Hive veritabanındaki kullanıcı verilerini sil
      await Hive.deleteFromDisk();

      // 5. SharedPreferences'taki tüm verileri temizle
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Ekstra temizlik işlemleri gerekebilir
    } catch (e) {
      throw Exception('Error deleting user: $e');
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

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      log("Password reset email sent");
    } catch (e) {
      log("Error sending password reset email: $e");
      rethrow;
    }
  }
}
