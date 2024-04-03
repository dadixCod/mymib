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
  List<String> basicCompany = [
    "●	Numérisez vos tickets de caisse, factures et autres documents afin de permettre une identification et une catégorisation automatiques de vos transactions.",
    "●	Optimisez votre temps et simplifiez la gestion de vos finances.",
    "●	Accédez à des rapports détaillés et à des graphiques pour visualiser vos dépenses et suivre votre progression.",
    "●	Configurez des alertes de dépenses pour rester informé et contrôler votre budget.",
    "●	Suivez vos objectifs financiers et facilitez l'atteinte de vos aspirations.",
  ];
  List<String> basicCompanyArabic = [
    "● قم بمسح تذاكر الشراء والفواتير والمستندات الأخرى لتمكين التعرف التلقائي والتصنيف التلقائي لمعاملاتك.",
    "● قم بتحسين وقتك وبسط إدارة أمورك المالية.",
    "● احصل على تقارير مفصلة ورسوم بيانية لتصور مصاريفك وتتبع تقدمك.",
    "● قم بتكوين تنبيهات للمصاريف لتظل على اطلاع والسيطرة على ميزانيتك.",
    "● تتبع أهدافك المالية وتسهل تحقيق طموحاتك.",
  ];
  List<String> basicCompanyEnglish = [
    "● Scan your purchase receipts, invoices, and other documents to enable automatic identification and categorization of your transactions.",
    "● Optimize your time and simplify the management of your finances.",
    "● Access detailed reports and graphs to visualize your expenses and track your progress.",
    "● Set expense alerts to stay informed and control your budget.",
    "● Track your financial goals and facilitate the achievement of your aspirations.",
  ];
  List<String> solutionCompanyOptionTexts = [
    "●	Inclus tous les avantages de l'option Basique",
    "●	Collaboration pour attirer davantage de clients et augmenter vos revenus"
  ];
  List<String> solutionCompanyOptionTextsArabic = [
    "● تشمل جميع مزايا الخيار الأساسي",
    "● التعاون لجذب المزيد من العملاء وزيادة عائداتك",
  ];
  List<String> solutionCompanyOptionTextsEnglish = [
    "● Includes all the benefits of the Basic option",
    "● Collaboration to attract more clients and increase your revenue",
  ];

  List<String> topMibTexts = [
    "●	Les avantages sont disponibles sur demande via nos représentants commerciaux."
  ];
  List<String> topMibTextsArabic = [
    "● الفوائد متاحة حسب الطلب من خلال ممثلينا التجاريين.",
  ];
  List<String> topMibTextsEnglish = [
    "● Benefits are available upon request through our sales representatives.",
  ];
}
