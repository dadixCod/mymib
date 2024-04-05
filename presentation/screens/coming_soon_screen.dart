import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('selectedLanguage');
    if (language != null) {
      if (language == 'fr') {
        return 'fr';
      } else {
        return 'en';
      }
    } else {
      return 'fr';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<String>(
            future: getLanguage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitFadingCircle(
                  color: context.colorScheme.primary,
                );
              }
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Image.asset(
                          snapshot.data == 'en'
                              ? 'assets/images/comingsoon.png'
                              : 'assets/images/bientodispo.png',
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
