import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/data/models/user_model.dart';
import 'package:mymib/presentation/screens/home_screen.dart';
import 'package:mymib/presentation/screens/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/presentation/screens/person_type_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: context.colorScheme.primary,
                size: 50,
              ),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data is UserModel) {
              return const HomeScreen();
            } else {
              // User needs to choose their type, navigate to type selection screen
              return const PersonTypeScreen();
            }
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}