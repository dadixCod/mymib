import 'package:flutter/material.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/presentation/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: context.colorScheme.primary,
              ),
            );
          } else if (snapshot.hasData) {
            final isLoggedIn = snapshot.data!.getBool('isLoggedIn');
            if (isLoggedIn == true) {
              return const MainScreen();
            } else {
              return const LoginScreen();
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
