import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/presentation/widgets/contact_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'offer_card.dart';

class CompanyPremium extends StatefulWidget {
  const CompanyPremium({super.key});

  @override
  State<CompanyPremium> createState() => _CompanyPremiumState();
}

class _CompanyPremiumState extends State<CompanyPremium> {
  late List<String> basicOptionsOne = [];
  late List<String> solutionOptionsTwo = [];
  late List<String> topMibTexts = [];
  Future<String?> setLists() async {
    final constants = Constants();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selectedLanguage');
    if (savedLanguage != null) {
      if (savedLanguage == 'ar') {
        basicOptionsOne = constants.basicCompanyArabic;
        solutionOptionsTwo = constants.solutionCompanyOptionTextsArabic;
        topMibTexts = constants.topMibTextsArabic;
      } else if (savedLanguage == 'fr') {
        basicOptionsOne = constants.basicCompany;
        solutionOptionsTwo = constants.solutionCompanyOptionTexts;
        topMibTexts = constants.topMibTexts;
      } else if (savedLanguage == 'en') {
        basicOptionsOne = constants.basicCompanyEnglish;
        solutionOptionsTwo = constants.solutionCompanyOptionTextsEnglish;
        topMibTexts = constants.topMibTextsEnglish;
      }
      return savedLanguage;
    } else {
      savedLanguage = 'fr';
      basicOptionsOne = constants.basicCompany;
      solutionOptionsTwo = constants.solutionCompanyOptionTexts;
      topMibTexts = constants.topMibTexts;
      return savedLanguage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    final constants = Constants(deviseSize: deviseSize);
    final autoTexts = S.of(context);
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
                    headline: autoTexts.forSmallBusiness,
                    optionTitle: autoTexts.basicOption,
                    price: '2800 ${autoTexts.pricingPerTr}',
                    list: basicOptionsOne,
                  ),
                  SizedBox(height: constants.tenVertical * 3),
                  OfferCard(
                    headline: autoTexts.forSmallBusiness,
                    optionTitle: autoTexts.solutionOption,
                    price: '4900 ${autoTexts.pricingPerTr}',
                    height: deviseSize.height * 0.28,
                    listHight: deviseSize.height * 0.18,
                    list: solutionOptionsTwo,
                  ),
                  SizedBox(height: constants.tenVertical * 3),
                  OfferCard(
                    headline: autoTexts.forBigCompanies,
                    optionTitle: autoTexts.topMib,
                    price: '8900 ${autoTexts.pricingPerTr}',
                    height: deviseSize.height * 0.3,
                    listHight: deviseSize.height * 0.2,
                    list: topMibTexts,
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
                      await EasyLauncher.call(number: '0555802426');
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
