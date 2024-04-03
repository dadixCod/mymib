// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class Constants {
  final Size? deviseSize;
  Constants({
     this.deviseSize,
  });

  double get tenVertical => deviseSize!.height * 0.013;
  List<String> basiqueOptionTexts = [
    "●	Scannez vos tickets de caisse, factures et autres documents pour une identification et une catégorisation automatiques de vos transactions.",
    "●	Gagnez du temps et simplifiez la gestion de vos finances.",
    "●	Consultez des rapports détaillés et graphiques pour visualiser vos dépenses et suivre votre progression.",
    "●	Définissez des alertes de dépenses pour rester informé et maîtriser votre budget.",
    "●	Suivez vos objectifs financiers et atteignez vos aspirations plus facilement.",
  ];
  List<String> basiqueOptionTextsArabic = [
    "● امسح تذاكر الشراء والفواتير والمستندات الأخرى لتحديد هوية معاملاتك وتصنيفها تلقائيًا.",
    "● وفّر الوقت وبسّط إدارة أمورك المالية.",
    "● استعرِض تقارير مفصلة ورسوم بيانية لتصور مصاريفك وتتبع تقدمك.",
    "● قم بتعيين تنبيهات للمصاريف لتظل على اطلاع وتسيطر على ميزانيتك.",
    "● تتبع أهدافك المالية وحقق طموحاتك بشكل أسهل.",
  ];
  List<String> basiqueOptionTextsEnglish = [
    "● Scan your purchase receipts, invoices, and other documents for automatic identification and categorization of your transactions.",
    "● Save time and simplify the management of your finances.",
    "● View detailed reports and graphs to visualize your expenses and track your progress.",
    "● Set expense alerts to stay informed and in control of your budget.",
    "● Track your financial goals and achieve your aspirations more easily.",
  ];
  List<String> solutionOptionTexts = [
    "●	Tous les avantages de l'option Basique",
    "●	Assistance prioritaire",
    "●	Propositions de réductions dans divers domaines via des codes promos avec des partenaires de confiance",
    "●	Carnet budgétaire personnalisé physique offert après 3 mois d'abonnement",
  ];

  List<String> solutionOptionTextsArabic = [
    "● جميع مزايا الخيار الأساسي",
    "● الدعم الأولوي",
    "● اقتراحات للخصومات في مجالات متنوعة عبر رموز ترويجية مع شركاء موثوق بهم",
    "● دفتر ميزانية شخصي مجاني يتم تقديمه بعد 3 أشهر من الاشتراك",
  ];
  List<String> solutionOptionTextsEnglish = [
    "● All the benefits of the Basic option",
    "● Priority assistance",
    "● Discount propositions in various domains via promo codes with trusted partners",
    "● Free physical personalized budget notebook offered after 3 months of subscription",
  ];
  List<String> solutionCompanyOptionTexts = [
    "●	Tous les avantages de l'option Basique",
    "●	Propositions de collaboration pour attirer plus de clients"
  ];
  List<String> solutionCompanyOptionTextsArabic = [
    "● جميع مزايا الخيار الأساسي",
    "● اقتراحات للتعاون لجذب المزيد من العملاء",
  ];
  List<String> solutionCompanyOptionTextsEnglish = [
    "● All the benefits of the Basic option",
    "● Collaboration proposals to attract more clients",
  ];

  List<String> topMibTexts = [
    '●	Accessible après 2 mois d\'abonnement "Solution"',
    "●	Tous les avantages de l'option La Solution",
    "●	Promotion de l'entreprise auprès d'un large public de clients"
  ];
  List<String> topMibTextsArabic = [
    '● يمكن الوصول إليه بعد 2 أشهر من الاشتراك في "الحل"',
    "● جميع مزايا الخيار 'الحل'",
    "● ترويج الشركة لجمهور واسع من العملاء",
  ];
  List<String> topMibTextsEnglish = [
    '● Accessible after 2 months of subscription to "Solution"',
    "● All the benefits of the 'Solution' option",
    "● Company promotion to a wide audience of clients",
  ];
}
