import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/repositories/user_repo.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>(_onSignInRequired);
    on<SignOutRequired>(_onSignOutRequired);
    on<UploadProfileImage>(_onUploadProfileImage);
    on<LoadUserProfile>(_onLoadUserProfile);
    on<LoadUserProfileImage>(_onLoadUserProfileImage);
    on<GoogleSignInRequired>(_onGoogleSignInRequired);
    on<ForgotPasswordRequired>(_onForgotPasswordRequired);
  }
  Future<void> _onSignInRequired(
      SignInRequired event, Emitter<SignInState> emit) async {
    emit(SignInProcess());
    try {
      await _userRepository.signIn(event.email, event.password);
      emit(SignInSuccess());

      // Kullanıcı verilerini hemen yükle
      add(LoadUserProfile());
    } on FirebaseAuthException catch (e) {
      emit(SignInFailure(message: e.code));
    } catch (e) {
      emit(const SignInFailure(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onLoadUserProfile(
      LoadUserProfile event, Emitter<SignInState> emit) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No user logged in');

      final doc =
          await _firebaseFirestore.collection('users').doc(user.uid).get();
      final data = doc.data();
      final name = data?['name'] as String? ?? '';
      final email = data?['email'] as String? ?? '';
      final profileImageUrl = data?['profileImageUrl'] as String? ?? '';

      emit(UserProfileLoaded(
        name: name,
        email: email,
        profileImageUrl: profileImageUrl,
      ));
    } catch (e) {
      emit(UserProfileLoadFailure(e.toString()));
    }
  }

  Future<void> _onSignOutRequired(
      SignOutRequired event, Emitter<SignInState> emit) async {
    await _userRepository.logOut();
    emit(SignOutSuccess());
  }

  Future<void> _onUploadProfileImage(
      UploadProfileImage event, Emitter<SignInState> emit) async {
    emit(ProfileImageUploading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No user logged in');

      final fileName =
          'profile_images/${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef = _firebaseStorage.ref().child(fileName);

      // Upload the image
      await storageRef.putFile(event.imageFile);
      final imageUrl = await storageRef.getDownloadURL();

      // Update user profile with the new image URL
      await _firebaseFirestore.collection('user').doc(user.uid).update({
        'profileImageUrl': imageUrl,
      });

      emit(ProfileImageUploadSuccess());
      add(LoadUserProfileImage()); // Trigger loading of the new profile image
    } catch (e) {
      emit(ProfileImageUploadFailure(e.toString()));
    }
  }

  Future<void> _onLoadUserProfileImage(
      LoadUserProfileImage event, Emitter<SignInState> emit) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No user logged in');

      final doc =
          await _firebaseFirestore.collection('user').doc(user.uid).get();
      final data = doc.data();
      final profileImageUrl = data?['profileImageUrl'] as String?;

      emit(ProfileImageLoaded(profileImageUrl: profileImageUrl));
    } catch (e) {
      emit(ProfileImageUploadFailure(e.toString()));
    }
  }

  Future<void> _onGoogleSignInRequired(
      GoogleSignInRequired event, Emitter<SignInState> emit) async {
    emit(SignInProcess());
    try {
      await _userRepository.signInWithGoogle();
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignInFailure(message: e.code));
    } catch (e) {
      emit(const SignInFailure());
    }
  }

  Future<void> _onForgotPasswordRequired(
      ForgotPasswordRequired event, Emitter<SignInState> emit) async {
    try {
      emit(SignInProcess());
      await _userRepository.resetPassword(event.email);
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(SignInFailure(message: e.toString()));
    }
  }
}
