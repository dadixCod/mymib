import 'package:flutter/material.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';

class ContactContainer extends StatelessWidget {
  const ContactContainer({
    super.key,
    this.onTap,
    required this.icon,
    required this.text,
    required this.backgroundColor,
  });
  final void Function()? onTap;
  final Widget icon;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final Size size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: constants.tenVertical * 5,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.background),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: context.colorScheme.background,
            )
          ],
        ),
      ),
    );
  }
}
