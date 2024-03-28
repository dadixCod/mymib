//You can use this widget to generate a circle Avatar
//with an Image inside it

import 'package:flutter/material.dart';
import 'package:mymib/core/utils/extensions.dart';

class MediaCircleAvatar extends StatelessWidget {
  final String imagePath;
  const MediaCircleAvatar({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: context.colorScheme.primary,
          ),
        ),
        child: Image.asset(imagePath),
      ),
    );
  }
}
