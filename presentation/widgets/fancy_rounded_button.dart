import 'package:flutter/material.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';

class FancyRoundedButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  final Color color;
  const FancyRoundedButton({
    super.key, this.onTap, required this.child, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: constants.tenVertical * 5,
        width: size.width * 0.88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Center(
          child: child
          
        ),
      ),
    );
  }
}
