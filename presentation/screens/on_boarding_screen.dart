// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/data/models/on_boarding.dart';
import 'package:mymib/presentation/widgets/rounded_button.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: pageIndex);

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            itemCount: onBoardingItems.length,
            itemBuilder: (context, index) {
              final onBoardingItem = onBoardingItems[index];
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Image.asset(
                        onBoardingItem.path,
                      ),
                    ),
                    SizedBox(height: constants.tenVertical * 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        onBoardingItem.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pageIndex == 0
                      ? const SizedBox()
                      : RoundedButton(
                          onTap: () {
                            if (pageIndex > 0) {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            }
                          },
                          text: S.of(context).prev,
                          bgColor: context.colorScheme.surfaceVariant,
                          textColor: context.colorScheme.primary,
                        ),
                  RoundedButton(
                    onTap: () async {
                      if (pageIndex < 2 && pageIndex >= 0) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else if (pageIndex == 2) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setInt('onboardingCompleted', 1);
                        Navigator.of(context).pushReplacementNamed('/auth');
                      }
                    },
                    text: pageIndex == 2
                        ? S.of(context).getStarted
                        : S.of(context).next,
                    bgColor: context.colorScheme.primary,
                    textColor: context.colorScheme.background,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            bottom: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onBoardingItems.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  width: index == pageIndex ? 25 : 13,
                  height: 13,
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: index == pageIndex
                        ? context.colorScheme.primary
                        : context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
