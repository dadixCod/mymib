import 'package:flutter/material.dart';
import 'package:mymib/presentation/screens/authentication_screen.dart';
import 'package:mymib/presentation/screens/home_screen.dart';
import 'package:mymib/presentation/screens/login_screen.dart';
import 'package:mymib/presentation/screens/on_boarding_screen.dart';
import 'package:mymib/presentation/screens/person_type_screen.dart';
import 'package:mymib/presentation/screens/sign_up_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/on_boarding':
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case '/auth':
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
      case '/sign_up':
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case '/log_in':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/person_type':
        return MaterialPageRoute(builder: (_) => const PersonTypeScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        throw 'Error getting route';
    }
  }
}
