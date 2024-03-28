// ignore_for_file: unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymib/data/models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserModel?> signUpUser(
      String email, String password, String displayName) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(displayName);
        return UserModel(
          id: user.uid,
          email: user.email,
          displayName: user.displayName ?? displayName,
        );
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> loginUser(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        return UserModel(
          id: user.uid,
          email: user.email,
          displayName: user.displayName,
        );
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> signOutUser() async {
    final User? user = auth.currentUser;
    if (user != null) {
      await auth.signOut();
    }
  }
}
