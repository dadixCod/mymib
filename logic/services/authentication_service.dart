// ignore_for_file: unused_catch_clause

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mymib/data/models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signUpUser(
      String email, String password, String displayName) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(displayName);
        return user;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> storeUserToFirestore(final String type) async {
    final User? user = auth.currentUser;
    CollectionReference users = firestore.collection('users');
    try {
      if (user != null) {
        await users.doc(user.uid).set({
          'userName': user.displayName,
          'email': user.email,
          'type': type,
        });
      }
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUsersData() async {
    final User? user = auth.currentUser;
    try {
      DocumentSnapshot userData =
          await firestore.collection('users').doc(user!.uid).get();
      if (userData.exists) {
        final Map<String, dynamic> userDataMap =
            userData.data() as Map<String, dynamic>;
        return UserModel.fromJson(userDataMap, user.uid);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      // final userData = await getUsersData();
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
    return null;
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        final userExists = await checkUserExists(userCredential.user!);
        return userExists;
      }
      
    } catch (e) {
      rethrow;
    }
    return false;
  }

  Future<bool> checkUserExists(User user) async {
    final docSnapshot = await firestore.collection('users').doc(user.uid).get();
    return docSnapshot.exists;
  }

  Future<void> signOutUser() async {
    final User? user = auth.currentUser;
    if (user != null) {
      await auth.signOut();
    }
  }
}
