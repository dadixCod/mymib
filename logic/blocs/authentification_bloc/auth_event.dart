import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {
  const AuthEvent();
  List<Object> get props => [];
}

class SignUpUser extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  SignUpUser({
    required this.email,
    required this.password,
    required this.displayName,
  });
  @override
  List<Object> get props => [email, password, displayName];
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  LoginUser({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class StoreUser extends AuthEvent {
  final String type;
  final User? user;
  const StoreUser(this.user, {required this.type});
}

class SignInWithGoogle extends AuthEvent {}

class SignOut extends AuthEvent {}
