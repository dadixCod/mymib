import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessSignOutState) {
            Navigator.of(context).pushReplacementNamed('/auth');
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user!.displayName!),
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOut());
                    },
                    child: isLoading
                        ? SpinKitFadingCircle(
                            color: context.colorScheme.primary,
                          )
                        : Text("Sign out")),
              ],
            ),
          );
        },
      ),
    );
  }
}
