import 'package:flutter/material.dart';
import 'package:mymib/data/models/transaction.dart';
import 'package:mymib/presentation/screens/edit_transaction_screen.dart';
import 'package:mymib/presentation/screens/premium_sceen.dart';
import '../../presentation/screens/screens.dart';

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

      case '/main_screen':
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case '/stats':
        return MaterialPageRoute(builder: (_) => const StatisticsScreen());
      case '/premium':
        return MaterialPageRoute(builder: (_) => const PremiumScreen());

      case '/add':
        return MaterialPageRoute(builder: (_) => const AddTransactionScreen());
      case '/edit_categories':
        {
          final fromRevenue = settings.arguments as bool;
          return MaterialPageRoute(
              builder: (_) =>  EditCategoriesScreen(fromRevenues: fromRevenue,));
        }
      case '/edit_transaction':
        {
          final transaction = settings.arguments as Transaction;
          return MaterialPageRoute(
              builder: (_) =>  EditTransactionScreen(transaction: transaction));
        }
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        throw 'Error getting route';
    }
  }
}
