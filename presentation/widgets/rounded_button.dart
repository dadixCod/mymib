//This is small rounded button used for example in the on boarding screen
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final Function()? onTap;
  const RoundedButton(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.textColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 400),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: bgColor,
                ),
                child: Text(
                  text,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: textColor),
                ),
              ),
            );
          }),
    );
  }
}
