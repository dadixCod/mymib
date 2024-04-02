import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/router/app_router.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/logic/blocs/categories_bloc.dart/bloc/category_bloc.dart';
import 'package:mymib/logic/blocs/date_bloc.dart/bloc/date_bloc.dart';
import 'package:mymib/logic/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:mymib/logic/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:mymib/logic/blocs/user_bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mymib/logic/blocs/authentification_bloc/auth_bloc.dart';
import '../../presentation/screens/screens.dart';
import 'core/theme/app_theme.dart';
import 'generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppRouter appRouter = AppRouter();
  String selectedLanguage = 'fr';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLanguage = prefs.getString('selectedLanguage');
  if (savedLanguage != null) {
    selectedLanguage = savedLanguage;
  }

  runApp(MainApp(
    appRouter: appRouter,
    selectedLanguage: selectedLanguage,
  ));
}

class MainApp extends StatelessWidget {
  final String selectedLanguage;
  final AppRouter appRouter;
  const MainApp(
      {super.key, required this.appRouter, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => DateBloc(),
        ),
        BlocProvider(
          create: (context) =>
              TransactionsBloc(dateBloc: BlocProvider.of<DateBloc>(context)),
        ),
        BlocProvider(
          create: (context) => StatisticsBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale(selectedLanguage),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: 'Roboto',
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          fontFamily: 'Roboto',
        ),
        home: Scaffold(
          body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCircle(
                    color: context.colorScheme.primary,
                  ),
                );
              }

              final SharedPreferences prefs = snapshot.data!;
              final int? onboardingCompleted =
                  prefs.getInt('onboardingCompleted');

              //check onboarding state
              if (onboardingCompleted != null && onboardingCompleted == 1) {
                // Onboarding already completed
                return const AuthenticationScreen();
              } else {
                return const OnBoardingScreen();
              }
            },
          ),
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
