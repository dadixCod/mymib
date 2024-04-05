import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/presentation/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<int> redirecting() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final onBoardingCompleted = prefs.getInt('onboardingCompleted');
    if (onBoardingCompleted != null && onBoardingCompleted == 1) {
      return 1;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: redirecting(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "My MIB",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.primary),
                  ),
                  const SizedBox(height: 60),
                  SpinKitFadingCircle(
                    color: context.colorScheme.primary,
                  )
                ],
              );
            } else if (snapshot.hasData) {
              if (snapshot.data == 1) {
                return const AuthenticationScreen();
              } else {
                return const OnBoardingScreen();
              }
            }
            return const SizedBox();
          }),
    );
  }
}
