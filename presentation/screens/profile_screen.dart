import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
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
              return GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(SignOut());
                },
                child: Container(
                  width: size.width,
                  height: constants.tenVertical * 5,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: context.colorScheme.outline,
                  ),
                  child: Center(
                    child: isLoading
                        ? SpinKitFadingCircle(
                            color:
                                context.colorScheme.background.withOpacity(0.8),
                          )
                        : Text(
                            "Sign out",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.background
                                  .withOpacity(0.8),
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


// BlocConsumer<UserBloc, UserState>(
//       listener: (context, state) {
//         if (state is LoadingUser) {
//           userLoading = state.isLoading;
//         } else if (state is FailedUserLoading) {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 content: Text(state.errorMessage),
//               );
//             },
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is UserLoaded) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(state.user.displayName!),
//                 Text(state.user.type!),
//                 BlocConsumer<AuthBloc, AuthState>(
//                   listener: (context, state) {
//                     if (state is AuthSuccessSignOutState) {
//                       Navigator.of(context).pushReplacementNamed('/log_in');
//                     }
//                     if (state is AuthLoadingState) {
//                       isLoading = state.isLoading;
//                     } else if (state is AuthFailureState) {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             content: Text(state.errorMessage),
//                           );
//                         },
//                       );
//                     }
//                   },
//                   builder: (context, state) {
//                     return TextButton(
//                         onPressed: () {
//                           context.read<AuthBloc>().add(SignOut());
//                         },
//                         child: isLoading
//                             ? SpinKitFadingCircle(
//                                 color: context.colorScheme.primary,
//                               )
//                             : const Text("Sign out"));
//                   },
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return SpinKitFadingCircle(
//             color: context.colorScheme.primary,
//           );
//         }
//       },
//     )
