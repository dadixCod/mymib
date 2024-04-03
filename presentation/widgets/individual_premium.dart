import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/presentation/widgets/contact_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'offer_card.dart';

class IndividualPremium extends StatefulWidget {
  const IndividualPremium({super.key});

  @override
  State<IndividualPremium> createState() => _IndividualPremiumState();
}

class _IndividualPremiumState extends State<IndividualPremium> {
  late List<String> basicOptionsOne = [];
  late List<String> solutionOptionsTwo = [];
  Future<String?> setLists() async {
    final constants = Constants();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selectedLanguage');
    if (savedLanguage != null) {
      if (savedLanguage == 'ar') {
        basicOptionsOne = constants.basiqueOptionTextsArabic;
        solutionOptionsTwo = constants.solutionCompanyOptionTextsArabic;
      } else if (savedLanguage == 'fr') {
        basicOptionsOne = constants.basiqueOptionTexts;
        solutionOptionsTwo = constants.solutionCompanyOptionTexts;
      } else if (savedLanguage == 'en') {
        basicOptionsOne = constants.basiqueOptionTextsEnglish;
        solutionOptionsTwo = constants.solutionCompanyOptionTextsEnglish;
      }
      return savedLanguage;
    } else {
      savedLanguage = 'fr';
      return savedLanguage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    final autoTexts = S.of(context);
    final constants = Constants(deviseSize: MediaQuery.of(context).size);
    return FutureBuilder(
        future: setLists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: context.colorScheme.primary,
              ),
            );
          }
          return Container(
            height: deviseSize.height,
            width: deviseSize.width,
            padding: EdgeInsets.symmetric(
                vertical: constants.tenVertical * 2, horizontal: 15),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OfferCard(
                    headline: autoTexts.headlineBasic,
                    optionTitle: autoTexts.basicOption,
                    price: '390 ${autoTexts.pricing}',
                    list: basicOptionsOne,
                  ),
                  SizedBox(height: constants.tenVertical * 3),
                  OfferCard(
                    optionTitle: autoTexts.solutionOption,
                    price: '990 ${autoTexts.pricing}',
                    height: deviseSize.height * 0.35,
                    listHight: deviseSize.height * 0.3,
                    list: solutionOptionsTwo,
                  ),
                  SizedBox(height: constants.tenVertical * 2),
                  Text(
                    autoTexts.contact,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: constants.tenVertical * 1),
                  ContactContainer(
                    onTap: () async {
                      await EasyLauncher.email(
                          email: 'mymibsolution@gmail.com');
                    },
                    icon: Icon(
                      Icons.email_outlined,
                      color: context.colorScheme.background,
                    ),
                    text: autoTexts.email,
                    backgroundColor: context.colorScheme.onPrimaryContainer,
                  ),
                  SizedBox(height: constants.tenVertical * 1),
                  ContactContainer(
                    onTap: () async {
                      await EasyLauncher.call(number: '0655741903');
                    },
                    icon: Icon(
                      Icons.phone,
                      color: context.colorScheme.background,
                    ),
                    text: autoTexts.callUs,
                    backgroundColor: context.colorScheme.onTertiaryContainer,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
