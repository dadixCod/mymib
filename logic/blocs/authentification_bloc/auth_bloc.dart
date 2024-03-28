
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymib/data/models/user_model.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';
import 'package:mymib/logic/services/authentication_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService authService = AuthenticationService();
  AuthBloc() : super(AuthInitState()) {
    on<SignUpUser>(
      (event, emit) async {
        emit(const AuthLoadingState(isLoading: true));
        try {
          final UserModel? user = await authService.signUpUser(
            event.email,
            event.password,
            event.displayName,
          );
          if (user != null) {
            emit(AuthSuccessState(user));
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
    on<LoginUser>(
      (event, emit) async {
        emit(const AuthLoadingState(isLoading: true));
        try {
          final UserModel? user = await authService.loginUser(
            event.email,
            event.password,
          );
          if (user != null) {
            emit(AuthSuccessState(user));
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
    on<SignOut>(
      (event, emit) async {
        emit(const AuthLoadingState(isLoading: true));
        try {
          await authService.signOutUser();
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
