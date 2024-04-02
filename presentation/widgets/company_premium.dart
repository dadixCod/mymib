import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/presentation/widgets/contact_container.dart';

import 'offer_card.dart';

class CompanyPremium extends StatefulWidget {
  const CompanyPremium({super.key});

  @override
  State<CompanyPremium> createState() => _CompanyPremiumState();
}

class _CompanyPremiumState extends State<CompanyPremium> {
  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    final constants = Constants(deviseSize: deviseSize);
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
              headline:
                  "Dites adieu à la saisie manuelle et optimisez vos finances !",
              optionTitle: 'Option Basique',
              price: '550 Da/mois',
              list: constants.basiqueOptionTexts,
            ),
            SizedBox(height: constants.tenVertical * 3),
            OfferCard(
              optionTitle: 'Option La Solution',
              price: '1400 DA/mois',
              height: deviseSize.height * 0.2,
              listHight: deviseSize.height * 0.15,
              list: constants.solutionCompanyOptionTexts,
            ),
            SizedBox(height: constants.tenVertical * 3),
            OfferCard(
              optionTitle: 'Top MIB',
              price: '2900 DA/mois',
              height: deviseSize.height * 0.3,
              listHight: deviseSize.height * 0.2,
              list: constants.topMibTexts,
            ),
            SizedBox(height: constants.tenVertical * 2),
            const Text(
              "Contactez-nous",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: constants.tenVertical * 1),
            ContactContainer(
              onTap: () async {
                await EasyLauncher.email(email: 'mymibsolution@gmail.com');
              },
              icon: Icon(
                Icons.email_outlined,
                color: context.colorScheme.background,
              ),
              text: 'Email',
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
              text: 'Appelez-nous',
              backgroundColor: context.colorScheme.onTertiaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
