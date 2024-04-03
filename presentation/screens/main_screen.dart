import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/logic/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:mymib/presentation/screens/home_screen.dart';
import 'package:mymib/presentation/screens/premium_sceen.dart';
import 'package:mymib/presentation/screens/profile_screen.dart';
import 'package:mymib/presentation/screens/statistics_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final List screens = [
  const HomeScreen(),
  const StatisticsScreen(),
  const PremiumScreen(),
  const ProfileScreen(),
];

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<NavigationBloc>().add(PageChanged(pageIndex: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autoTexts = S.of(context);
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: screens[state.pageIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: context.colorScheme.outline.withOpacity(0.3),
            selectedItemColor: context.colorScheme.primary,
            elevation: 1,
            currentIndex: state.pageIndex,
            onTap: (index) {
              context.read<NavigationBloc>().add(
                    PageChanged(pageIndex: index),
                  );
            },
            items: [
              BottomNavigationBarItem(
                // backgroundColor: Colors.transparent,
                label: autoTexts.acceuil,
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4),
                  child: Image.asset(
                    'assets/icons/home.png',
                    height: 25,
                    width: 25,
                    color: context.colorScheme.outline.withOpacity(0.4),
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4),
                  child: Image.asset(
                    'assets/icons/home_filled.png',
                    height: 25,
                    width: 25,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                // backgroundColor: Colors.transparent,
                label: autoTexts.stats,
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4),
                  child: Image.asset(
                    'assets/icons/circle_chart.png',
                    height: 25,
                    width: 25,
                    color: context.colorScheme.outline.withOpacity(0.4),
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4),
                  child: Image.asset(
                    'assets/icons/circle_chart_filled.png',
                    height: 25,
                    width: 25,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                // backgroundColor: Colors.transparent,
                label: autoTexts.premium,
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4),
                  child: Image.asset(
                    'assets/icons/premium.png',
                    height: 25,
                    width: 25,
                    color: context.colorScheme.outline.withOpacity(0.4),
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4),
                  child: Image.asset(
                    'assets/icons/premium_filled.png',
                    height: 25,
                    width: 25,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                // backgroundColor: Colors.transparent,
                label: autoTexts.profile,
                icon: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4),
                  child: Image.asset(
                    'assets/icons/user.png',
                    color: context.colorScheme.outline.withOpacity(0.4),
                    height: 25,
                    width: 25,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 4),
                  child: Image.asset(
                    'assets/icons/user_filled.png',
                    color: context.colorScheme.primary,
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
