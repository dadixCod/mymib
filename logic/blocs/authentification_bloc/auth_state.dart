
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {
  const AuthState();
  List<Object> get props => [];
}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {
  final bool isLoading;
  const AuthLoadingState({required this.isLoading});
}

class AuthSuccessState extends AuthState {
  // final UserModel user;
  const AuthSuccessState();
  @override
  List<Object> get props => [];
}
class AuthSuccessLoginState extends AuthState {
  final User? user;
  const AuthSuccessLoginState(this.user);
  @override
  List<Object> get props => [];
}
class AuthSuccessSignUpState extends AuthState {
  final User user;
  const AuthSuccessSignUpState(this.user);
  @override
  List<Object> get props => [user];
}
class AuthSuccessSignOutState extends AuthState {
  
  const AuthSuccessSignOutState();
  @override
  List<Object> get props => [];
}

class AuthFailureState extends AuthState {
  final String errorMessage;
  const AuthFailureState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class GoogleUserExist extends AuthState{}
class GoogleUserNotExist extends AuthState{}

