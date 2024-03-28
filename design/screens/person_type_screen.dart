import 'package:flutter/material.dart';
import 'package:mymib/core/utils/extensions.dart';

import '../../generated/l10n.dart';

class PersonTypeScreen extends StatefulWidget {
  const PersonTypeScreen({super.key});

  @override
  State<PersonTypeScreen> createState() => _PersonTypeScreenState();
}

class _PersonTypeScreenState extends State<PersonTypeScreen> {
  var isIndividual = true;
  @override
  Widget build(BuildContext context) {
    final autoTexts = S.of(context);
    final size = context.deviceSize;
    return Center(
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
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
