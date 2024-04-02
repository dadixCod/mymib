import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/presentation/widgets/contact_container.dart';

import 'offer_card.dart';

class IndividualPremium extends StatefulWidget {
  const IndividualPremium({super.key});

  @override
  State<IndividualPremium> createState() => _IndividualPremiumState();
}

class _IndividualPremiumState extends State<IndividualPremium> {
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
              optionTitle: 'Option 1 Basique',
              price: '390 Da/mois',
              list: constants.basiqueOptionTexts,
            ),
            SizedBox(height: constants.tenVertical * 3),
            OfferCard(
              optionTitle: 'Option 2 La Solution',
              price: '990 DA/mois',
              height: deviseSize.height * 0.35,
              listHight: deviseSize.height * 0.3,
              list: constants.solutionOptionTexts,
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
