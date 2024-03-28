import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';

import 'package:mymib/logic/blocs/user_bloc/user_bloc.dart';
import 'package:mymib/logic/blocs/user_bloc/user_event.dart';
import 'package:mymib/logic/blocs/user_bloc/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLoading = false;
  var userLoading = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(LoadUser());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is LoadingUser) {
            userLoading = state.isLoading;
          } else if (state is FailedUserLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.errorMessage),
                  );
                });
          }
        },
        builder: (context, state) {
          if (state is UserLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.user.displayName!),
                  Text(state.user.type!),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccessSignOutState) {
                        Navigator.of(context).pushReplacementNamed('/log_in');
                      }
                      if (state is AuthLoadingState) {
                        isLoading = state.isLoading;
                      } else if (state is AuthFailureState) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(state.errorMessage),
                            );
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(SignOut());
                          },
                          child: isLoading
                              ? SpinKitFadingCircle(
                                  color: context.colorScheme.primary,
                                )
                              : const Text("Sign out"));
                    },
                  ),
                ],
              ),
            );
          } else {
            return SpinKitFadingCircle(
              color: context.colorScheme.primary,
            );
          }
        },
      ),
    );
  }
}
