// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';

class Constants {
  final Size deviseSize;
  Constants({
    required this.deviseSize,
  });

  double get tenVertical => deviseSize.height * 0.013;
  List<String> basiqueOptionTexts = [
  "●	Scannez vos tickets de caisse, factures et autres documents pour une identification et une catégorisation automatiques de vos transactions.",
  "●	Gagnez du temps et simplifiez la gestion de vos finances.",
  "●	Consultez des rapports détaillés et graphiques pour visualiser vos dépenses et suivre votre progression.",
  "●	Définissez des alertes de dépenses pour rester informé et maîtriser votre budget.",
  "●	Suivez vos objectifs financiers et atteignez vos aspirations plus facilement.",
];
 List<String> solutionOptionTexts = [
  "●	Tous les avantages de l'option Basique",
  "●	Assistance prioritaire",
  "●	Propositions de réductions dans divers domaines via des codes promos avec des partenaires de confiance",
  "●	Carnet budgétaire personnalisé physique offert après 3 mois d'abonnement",
];
 List<String> solutionCompanyOptionTexts = [
  "●	Tous les avantages de l'option Basique",
  "●	Propositions de collaboration pour attirer plus de clients"
];

 List<String> topMibTexts = [
  '●	Accessible après 2 mois d\'abonnement "Solution"',
  "●	Tous les avantages de l'option La Solution",
  "●	Promotion de l'entreprise auprès d'un large public de clients"
];


}
