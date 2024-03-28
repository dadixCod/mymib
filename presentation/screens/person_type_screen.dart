import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_event.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_state.dart';

import '../../generated/l10n.dart';

class PersonTypeScreen extends StatefulWidget {
  const PersonTypeScreen({super.key});

  @override
  State<PersonTypeScreen> createState() => _PersonTypeScreenState();
}

class _PersonTypeScreenState extends State<PersonTypeScreen> {
  var isIndividual = true;
  var isLoading = false;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final autoTexts = S.of(context);
    final size = context.deviceSize;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              autoTexts.youAre,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                setState(() {
                  isIndividual = true;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: size.width,
                height: size.height * 0.07,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: context.colorScheme.primary,
                    ),
                    color: isIndividual
                        ? context.colorScheme.primary
                        : context.colorScheme.secondary.withOpacity(0.1)),
                child: Center(
                  child: Text(
                    autoTexts.individual,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isIndividual
                          ? context.colorScheme.background
                          : context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isIndividual = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: size.width,
                height: size.height * 0.07,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: context.colorScheme.primary,
                  ),
                  color: isIndividual
                      ? context.colorScheme.secondary.withOpacity(0.1)
                      : context.colorScheme.primary,
                ),
                child: Center(
                  child: Text(
                    autoTexts.company,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isIndividual
                          ? context.colorScheme.primary
                          : context.colorScheme.background,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessState) {
                  Navigator.of(context).pushReplacementNamed('/home');
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
                return GestureDetector(
                  onTap: () {
                    if (isIndividual) {
                      context
                          .read<AuthBloc>()
                          .add( StoreUser(user , type: 'individual'));
                    } else {
                      context
                          .read<AuthBloc>()
                          .add( StoreUser(user,type: 'company'));
                    }
                  },
                  child: isLoading
                      ? SpinKitFadingCircle(
                          color: context.colorScheme.primary,
                        )
                      : Container(
                          width: size.width * 0.85,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: context.colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              autoTexts.continueText,
                              style: context.textTheme.titleLarge?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
