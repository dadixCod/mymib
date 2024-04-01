import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';
import 'package:mymib/logic/blocs/user_bloc/user_bloc.dart';
import 'package:mymib/logic/blocs/user_bloc/user_event.dart';
import 'package:mymib/logic/blocs/user_bloc/user_state.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isLoading = false;
  var userLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
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
                },
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoaded) {
              return Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, bottom: 10, top: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileInfoContainer(
                            title: "Nom d'utilisateur: ",
                            content: state.user.displayName!,
                          ),
                          SizedBox(height: constants.tenVertical),
                          ProfileInfoContainer(
                            title: 'Email: ',
                            content: state.user.email!,
                          ),
                          SizedBox(height: constants.tenVertical),
                          ProfileInfoContainer(
                            title: 'Type: ',
                            content: state.user.type!,
                          ),
                          SizedBox(height: constants.tenVertical * 4),
                          const Text(
                            'Contactez -nous',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: constants.tenVertical * 2),
                          ContactContainer(
                            onTap: () async {
                              await EasyLauncher.email(
                                  email: 'mymibsolution@gmail.com');
                            },
                            icon: Icons.mail_outline_outlined,
                            text: 'Email',
                            backgroundColor:
                                context.colorScheme.secondaryContainer,
                          ),
                          SizedBox(height: constants.tenVertical * 2),
                          ContactContainer(
                            onTap: () async {
                              await EasyLauncher.call(number: '0655741903');
                            },
                            icon: Icons.phone,
                            text: 'Appeler nous',
                            backgroundColor:
                                context.colorScheme.tertiaryContainer,
                          ),
                        ],
                      ),
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
                                      color: context.colorScheme.background
                                          .withOpacity(0.8),
                                    )
                                  : Text(
                                      "Déconnexion",
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
            } else {
              context.read<UserBloc>().add(LoadUser());
              return SpinKitFadingCircle(
                color: context.colorScheme.primary,
              );
            }
          },
        ));
  }
}

class ContactContainer extends StatelessWidget {
  const ContactContainer({
    super.key,
    this.onTap,
    required this.icon,
    required this.text,
    required this.backgroundColor,
  });
  final void Function()? onTap;
  final IconData icon;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final Size size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: constants.tenVertical * 5,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}

class ProfileInfoContainer extends StatelessWidget {
  const ProfileInfoContainer({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return Container(
      width: size.width,
      height: constants.tenVertical * 5,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.outline.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}


      // body: Column(
      //   children: [
      //     Expanded(
      //       child: Container(
      //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //         child: Center(
      //           child: Column(
      //             children: [
      //               Text(''),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     BlocConsumer<AuthBloc, AuthState>(
      //       listener: (context, state) {
      //         if (state is AuthSuccessSignOutState) {
      //           Navigator.of(context).pushReplacementNamed('/log_in');
      //         }
      //         if (state is AuthLoadingState) {
      //           isLoading = state.isLoading;
      //         } else if (state is AuthFailureState) {
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
      //         return GestureDetector(
      //           onTap: () {
      //             context.read<AuthBloc>().add(SignOut());
      //           },
      //           child: Container(
      //             width: size.width,
      //             height: constants.tenVertical * 5,
      //             margin: const EdgeInsets.symmetric(horizontal: 15),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(15),
      //               color: context.colorScheme.outline,
      //             ),
      //             child: Center(
      //               child: isLoading
      //                   ? SpinKitFadingCircle(
      //                       color:
      //                           context.colorScheme.background.withOpacity(0.8),
      //                     )
      //                   : Text(
      //                       "Sign out",
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                         color: context.colorScheme.background
      //                             .withOpacity(0.8),
      //                       ),
      //                     ),
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),