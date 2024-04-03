// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `My MIB`
  String get title {
    return Intl.message(
      'My MIB',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `My MIB is a revolutionary financial management solution that allows you to take control of your finances and achieve your dreams`
  String get page1Desc {
    return Intl.message(
      'My MIB is a revolutionary financial management solution that allows you to take control of your finances and achieve your dreams',
      name: 'page1Desc',
      desc: '',
      args: [],
    );
  }

  /// `Manage your income and expenses, track your spending, and plan your financial future with ease using My MIB`
  String get page2Desc {
    return Intl.message(
      'Manage your income and expenses, track your spending, and plan your financial future with ease using My MIB',
      name: 'page2Desc',
      desc: '',
      args: [],
    );
  }

  /// `Visualize your financial situation at a glance and reduce your expenses. Take advantage of exclusive offers from our partners to save on your daily purchases`
  String get page3Desc {
    return Intl.message(
      'Visualize your financial situation at a glance and reduce your expenses. Take advantage of exclusive offers from our partners to save on your daily purchases',
      name: 'page3Desc',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get prev {
    return Intl.message(
      'Previous',
      name: 'prev',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAccount {
    return Intl.message(
      'Create an account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Welcome again`
  String get welcomeAgain {
    return Intl.message(
      'Welcome again',
      name: 'welcomeAgain',
      desc: '',
      args: [],
    );
  }

  /// `We are glad to have you on board`
  String get signupDesc {
    return Intl.message(
      'We are glad to have you on board',
      name: 'signupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signout {
    return Intl.message(
      'Sign out',
      name: 'signout',
      desc: '',
      args: [],
    );
  }

  /// `Have an account?`
  String get didHaveAccount {
    return Intl.message(
      'Have an account?',
      name: 'didHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `You don''t have an account?`
  String get didNotHaveAccount {
    return Intl.message(
      'You don\'\'t have an account?',
      name: 'didNotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Must be atleast 6 characters long`
  String get invalidUsername {
    return Intl.message(
      'Must be atleast 6 characters long',
      name: 'invalidUsername',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get invalidEmail {
    return Intl.message(
      'Enter a valid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email should not be null`
  String get emptyEmail {
    return Intl.message(
      'Email should not be null',
      name: 'emptyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Must be atleast 8 characters long`
  String get invalidPassword {
    return Intl.message(
      'Must be atleast 8 characters long',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get contineWith {
    return Intl.message(
      'Or continue with',
      name: 'contineWith',
      desc: '',
      args: [],
    );
  }

  /// `You are ?`
  String get youAre {
    return Intl.message(
      'You are ?',
      name: 'youAre',
      desc: '',
      args: [],
    );
  }

  /// `Individual`
  String get individual {
    return Intl.message(
      'Individual',
      name: 'individual',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get individualRevenues {
    return Intl.message(
      'Income',
      name: 'individualRevenues',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get individualExpenses {
    return Intl.message(
      'Expenses',
      name: 'individualExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get companyRevenues {
    return Intl.message(
      'Income',
      name: 'companyRevenues',
      desc: '',
      args: [],
    );
  }

  /// `Expenditures`
  String get companyExpenses {
    return Intl.message(
      'Expenditures',
      name: 'companyExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `AD`
  String get currency {
    return Intl.message(
      'AD',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this transaction?`
  String get confirmDeleteTransaction {
    return Intl.message(
      'Do you want to delete this transaction?',
      name: 'confirmDeleteTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Your categories`
  String get your_categories {
    return Intl.message(
      'Your categories',
      name: 'your_categories',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get selectedLangue {
    return Intl.message(
      'Language',
      name: 'selectedLangue',
      desc: '',
      args: [],
    );
  }

  /// `Relaunch the application for all changes to take effect`
  String get restartApp {
    return Intl.message(
      'Relaunch the application for all changes to take effect',
      name: 'restartApp',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get acceuil {
    return Intl.message(
      'Home',
      name: 'acceuil',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get stats {
    return Intl.message(
      'Statistics',
      name: 'stats',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get premium {
    return Intl.message(
      'Premium',
      name: 'premium',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Add new transactions`
  String get addNewTransactions {
    return Intl.message(
      'Add new transactions',
      name: 'addNewTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `No transactions on this day.`
  String get noTransactions {
    return Intl.message(
      'No transactions on this day.',
      name: 'noTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `This list of categories is empty`
  String get emptyCategoriesList {
    return Intl.message(
      'This list of categories is empty',
      name: 'emptyCategoriesList',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this category?`
  String get confirmDeleteCategorie {
    return Intl.message(
      'Do you want to delete this category?',
      name: 'confirmDeleteCategorie',
      desc: '',
      args: [],
    );
  }

  /// `Category is empty`
  String get emptyCategory {
    return Intl.message(
      'Category is empty',
      name: 'emptyCategory',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get ok {
    return Intl.message(
      'Okay',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Add a Transaction`
  String get addTransaction {
    return Intl.message(
      'Add a Transaction',
      name: 'addTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Edit transaction`
  String get editTransaction {
    return Intl.message(
      'Edit transaction',
      name: 'editTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Fill in at least one of the amounts`
  String get transactionValidator {
    return Intl.message(
      'Fill in at least one of the amounts',
      name: 'transactionValidator',
      desc: '',
      args: [],
    );
  }

  /// `Call us `
  String get callUs {
    return Intl.message(
      'Call us ',
      name: 'callUs',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Amount (AD)`
  String get amountInDa {
    return Intl.message(
      'Amount (AD)',
      name: 'amountInDa',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contact {
    return Intl.message(
      'Contacts',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Basic Option 1`
  String get basicOptionOne {
    return Intl.message(
      'Basic Option 1',
      name: 'basicOptionOne',
      desc: '',
      args: [],
    );
  }

  /// `Solution Option 2`
  String get solutionOptionTwo {
    return Intl.message(
      'Solution Option 2',
      name: 'solutionOptionTwo',
      desc: '',
      args: [],
    );
  }

  /// `Basic Option`
  String get basicOption {
    return Intl.message(
      'Basic Option',
      name: 'basicOption',
      desc: '',
      args: [],
    );
  }

  /// `Solution Option`
  String get solutionOption {
    return Intl.message(
      'Solution Option',
      name: 'solutionOption',
      desc: '',
      args: [],
    );
  }

  /// `AD/month`
  String get pricing {
    return Intl.message(
      'AD/month',
      name: 'pricing',
      desc: '',
      args: [],
    );
  }

  /// `Say goodbye to manual entry and optimize your finances!`
  String get headlineBasic {
    return Intl.message(
      'Say goodbye to manual entry and optimize your finances!',
      name: 'headlineBasic',
      desc: '',
      args: [],
    );
  }

  /// `Top MIB`
  String get topMib {
    return Intl.message(
      'Top MIB',
      name: 'topMib',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
