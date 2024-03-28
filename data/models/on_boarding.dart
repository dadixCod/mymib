// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mymib/generated/l10n.dart';

class OnBoarding {
  final String path;
  final String description;
  OnBoarding({
    required this.path,
    required this.description,
  });
}

List<OnBoarding> onBoardingItems = [
  OnBoarding(
    path: 'assets/images/revenues.png',
    description: S.current.page1Desc,
  ),
  OnBoarding(
    path: 'assets/images/statistics.png',
    description: S.current.page2Desc.replaceFirst("'", ""),
  ),
  OnBoarding(
    path: 'assets/images/tracktax.png',
    description: S.current.page3Desc.replaceFirst("'", ""),
  ),
];
