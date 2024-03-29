// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/presentation/widgets/widgets.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  var isLoading = false;
  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autoTexts = S.of(context);
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: WaveClipperTwo(flip: true),
                child: Container(
                  color: context.colorScheme.primaryContainer,
                  height: 200,
                  child: Center(
                    child: Text(
                      autoTexts.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      autoTexts.createAccount,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: constants.tenVertical),

                    Text(
                      autoTexts.signupDesc,
                    ),
                    SizedBox(height: constants.tenVertical * 4.5),
                    // 3 text fields
                    RoundedTextField(
                      text: autoTexts.username.replaceFirst("'", ""),
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return autoTexts.invalidUsername;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constants.tenVertical * 1.5),
                    RoundedTextField(
                      text: autoTexts.email,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return autoTexts.emptyEmail;
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: constants.tenVertical * 1.5),
                    RoundedTextField(
                      obscure: true,
                      text: autoTexts.password,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return autoTexts.invalidPassword;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constants.tenVertical * 3),

                    //Sign up button
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccessSignUpState) {
                          Navigator.of(context)
                              .pushReplacementNamed('/person_type');
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
                              });
                        }
                      },
                      builder: (context, state) {
                        return RoundedActionButton(
                          onTap: () {
                            if (key.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    SignUpUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      displayName: usernameController.text,
                                    ),
                                  );
                            }
                          },
                          child: isLoading
                              ? SpinKitFadingCircle(
                                  color: context.colorScheme.background,
                                )
                              : Text(
                                  autoTexts.signup.replaceFirst("'", ""),
                                  style: context.textTheme.titleLarge?.copyWith(
                                    color: context.colorScheme.background,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        );
                      },
                    ),
                    SizedBox(height: constants.tenVertical),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          autoTexts.didHaveAccount,
                          style: context.textTheme.bodyLarge,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/log_in');
                          },
                          child: Text(
                            autoTexts.login,
                            style: context.textTheme.titleMedium?.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: constants.tenVertical * 2),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(autoTexts.contineWith),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: constants.tenVertical),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccessState) {
                          Navigator.of(context)
                              .pushReplacementNamed('/main_screen');
                        } else if (state is AuthFailureState) {
                          Navigator.of(context)
                              .pushReplacementNamed('/person_type');
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            context.read<AuthBloc>().add(SignInWithGoogle());
                          },
                          child: const MediaCircleAvatar(
                            imagePath: 'assets/icons/google.png',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
