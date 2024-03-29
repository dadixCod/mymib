import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymib/logic/blocs/user_bloc/user_event.dart';
import 'package:mymib/logic/blocs/user_bloc/user_state.dart';
import 'package:mymib/logic/services/authentication_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthenticationService authService = AuthenticationService();
  UserBloc() : super(UserInitState()) {
    on<LoadUser>((event, emit) async {
      emit(LoadingUser(isLoading: true));
      try {
        final user = await authService.getUsersData();
        debugPrint(user.toString());
        if (user != null) {
          emit(UserLoaded(user));
        } else {
          emit(const FailedUserLoading("User data is null"));
        }
      } catch (e) {
        emit(FailedUserLoading(e.toString()));
        emit(LoadingUser(isLoading: false));
      }
    });
  }
}
