import 'package:flutter/material.dart';
import 'package:mymib/core/utils/extensions.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Container(
                height: deviseSize.height * 0.2,
                width: deviseSize.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: context.colorScheme.primaryContainer,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 5,
                      color: context.colorScheme.primary.withOpacity(0.6),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/premium.png',
                        color: context.colorScheme.primary,
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(width: deviseSize.width * 0.07),
                      Text(
                        'Bientot disponible',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
