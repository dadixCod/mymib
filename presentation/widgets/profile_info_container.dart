import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymib/core/utils/extensions.dart';

class ProfileInfoContainer extends StatelessWidget {
  const ProfileInfoContainer({
    super.key,
    required this.title,
    required this.content,
    required this.selectedLanguage,
  });
  final String selectedLanguage;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.outline.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Flexible(
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
