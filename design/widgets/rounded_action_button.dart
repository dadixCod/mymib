import 'package:flutter/material.dart';
import 'package:mymib/core/utils/extensions.dart';

class RoundedActionButton extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  const RoundedActionButton({super.key, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
