import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';
import 'package:mymib/logic/services/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService authService = AuthenticationService();
  AuthBloc() : super(AuthInitState()) {
    on<SignUpUser>(
      (event, emit) async {
        emit(const AuthLoadingState(isLoading: true));
        try {
          final User? user = await authService.signUpUser(
            event.email,
            event.password,
            event.displayName,
          );
          if (user != null) {
            // emit(const AuthSuccessState());
            emit(AuthSuccessSignUpState(user));
          }
          emit(const AuthLoadingState(isLoading: false));
        } on FirebaseException catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        } catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        }
      },
    );
    on<StoreUser>(
      (event, emit) async {
        emit(const AuthLoadingState(isLoading: true));
        try {
          final userStored = await authService.storeUserToFirestore(event.type);
          if (userStored) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', true);
            emit(const AuthSuccessState());
          }
          emit(const AuthLoadingState(isLoading: true));
        } on FirebaseException catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        } catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        }
      },
    );
    on<LoginUser>(
      (event, emit) async {
        emit(const AuthLoadingState(isLoading: true));
        try {
          final User? user = await authService.loginUser(
            event.email,
            event.password,
          );
          if (user != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', true);
            emit(AuthSuccessLoginState(user));
          } else {
            emit(const AuthFailureState('Email or password are wrong'));
          }
          emit(const AuthLoadingState(isLoading: false));
        } on FirebaseException catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        } catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        }
      },
    );
    on<SignInWithGoogle>(
      (event, emit) async {
        emit(const AuthLoadingState(isLoading: true));
        try {
          final bool userExists = await authService.signInWithGoogle();
          if (userExists) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', true);
            emit(GoogleUserExist());
          } else {
            emit(GoogleUserNotExist());
          }
          emit(const AuthLoadingState(isLoading: false));
        } on FirebaseAuthException catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        } catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        }
      },
    );
    on<SignOut>(
      (event, emit) async {
        emit(const AuthLoadingState(isLoading: true));
        try {
          await authService.signOutUser();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', false);
          emit(const AuthSuccessSignOutState());
        } catch (e) {
          emit(AuthFailureState(e.toString()));
          emit(const AuthLoadingState(isLoading: false));
        }
        emit(const AuthLoadingState(isLoading: false));
      },
    );
  }
}
