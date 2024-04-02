// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mymib/core/constants/constants.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/logic/blocs/categories_bloc.dart/bloc/category_bloc.dart';
import 'package:mymib/logic/blocs/date_bloc.dart/bloc/date_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_event.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_state.dart';
import 'package:mymib/logic/blocs/user_bloc/user_bloc.dart';
import 'package:mymib/logic/blocs/user_bloc/user_event.dart';
import 'package:mymib/logic/blocs/user_bloc/user_state.dart';
import 'package:mymib/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  bool isInitialized = false;
  var isLoading = false;
  var userLoading = false;
  var transactionsLoading = false;
  String type = '';
  DateTime oneSelectedDate = DateTime.now();

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();
    isInitialized = _prefs.getBool('initialized') ?? false;
    if (!isInitialized) {
      _initializeCategories();
    }
  }

  Future<void> _initializeCategories() async {
    context.read<CategoryBloc>().add(InitializeDefaultCategories());
    _prefs.setBool('initialized', true);
  }

  @override
  void initState() {
    _initialize();
    context.read<UserBloc>().add(LoadUser());

    context.read<TransactionsBloc>().add(LoadFilteredTransactions(
        DateTime.now(), FirebaseAuth.instance.currentUser!.uid));
    context.read<CategoryBloc>().add(GetCategories());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autoTexts = S.of(context);
    final size = context.deviceSize;
    Constants constants = Constants(deviseSize: size);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.colorScheme.surface,
        shadowColor: context.colorScheme.onBackground,
        elevation: 0.4,
        title: Text(
          autoTexts.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final dateRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(
                  const Duration(days: 3650),
                ),
                initialDateRange: DateTimeRange(
                  start: DateTime.now().subtract(const Duration(days: 30)),
                  end: DateTime.now(),
                ),
              );
              log(dateRange.toString());
              if (dateRange != null) {
                context.read<DateBloc>().add(SelectDateRange(
                    startDate: dateRange.start, endDate: dateRange.end));
              }
              return;
            },
            icon: const Icon(Icons.date_range),
          ),
        ],
        leadingWidth: 100,
        leading: SizedBox(
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(
                      const Duration(days: 3650),
                    ),
                  );
                  if (selectedDate != null) {
                    context
                        .read<DateBloc>()
                        .add(SelectOneDate(date: selectedDate));
                    setState(() {
                      oneSelectedDate = selectedDate;
                    });
                  }
                  return;
                },
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  size: 24,
                ),
              ),
              Text(
                DateFormat.Md().format(oneSelectedDate),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            type = state.user.type!;
          }
          if (state is LoadingUser) {
            setState(() {
              transactionsLoading = true;
            });
          }
        },
        builder: (context, state) {
          return BlocConsumer<TransactionsBloc, TransactionState>(
            listener: (context, state) {
              if (state is TransactionLoading) {
                setState(() {
                  transactionsLoading = true;
                });
              } else if (state is TransactionsLoaded) {
                setState(() {
                  transactionsLoading = false;
                });
              }
            },
            builder: (context, state) {
              if (state is TransactionLoading) {
                return Center(
                  child:
                      SpinKitFadingCircle(color: context.colorScheme.primary),
                );
              }
              if (state is TransactionsLoaded) {
                double totalExpenses = 0;
                double totalRevenues = 0;
                for (var transaction in state.transactions) {
                  totalExpenses += transaction.expenseAmount!;
                  totalRevenues += transaction.revenueAmount!;
                }
                double total = totalRevenues - totalExpenses;
                return SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      SizedBox(height: constants.tenVertical * 1.5),
                      //3 Containers of Total , income , expenses
                      GradientContainer(
                        height: constants.tenVertical * 7,
                        width: size.width * 0.95,
                        title: "Total :",
                        content: "${total.toString()} ${autoTexts.currency}",
                        gradientColors: [
                          context.colorScheme.primary
                              .withAlpha(100)
                              .withOpacity(0.3),
                          context.colorScheme.primary.withOpacity(0.7),
                        ],
                        centerContent: true,
                      ),
                      SizedBox(height: constants.tenVertical),
                      SizedBox(
                        height: constants.tenVertical * 7.5,
                        width: size.width * 0.95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GradientContainer(
                              height: constants.tenVertical * 7.5,
                              width: size.width * 0.45,
                              title: type == 'individual'
                                  ? '${autoTexts.individualRevenues} :'
                                  : '${autoTexts.companyRevenues} :',
                              content:
                                  "${totalRevenues.toString()} ${autoTexts.currency}",
                              gradientColors: [
                                Colors.blue.shade200
                                    .withAlpha(100)
                                    .withOpacity(0.4),
                                Colors.blue.shade100.withAlpha(200),
                              ],
                              centerContent: false,
                            ),
                            GradientContainer(
                              height: constants.tenVertical * 7.5,
                              width: size.width * 0.45,
                              title: type == 'individual'
                                  ? '${autoTexts.individualExpenses} :'
                                  : '${autoTexts.companyExpenses} :',
                              content:
                                  "${totalExpenses.toString()} ${autoTexts.currency}",
                              gradientColors: [
                                Colors.red.shade500.withOpacity(0.6),
                                Colors.red.shade500.withOpacity(0.8),
                              ],
                              centerContent: false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constants.tenVertical),
                      //This is the main widget , it shows the transactions of the selected date
                      Container(
                          height: size.height * 0.57,
                          width: size.width * 0.95,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: context.colorScheme.onBackground
                                .withOpacity(0.1),
                          ),
                          child: state.transactions.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/add_data.png',
                                        height: size.height * 0.3,
                                      ),
                                      SizedBox(height: constants.tenVertical),
                                      Text(
                                        "Ajouter des expenses et revenues",
                                        style: TextStyle(
                                          color: context.colorScheme.outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: state.transactions.length,
                                  itemBuilder: (context, index) {
                                    return TransactionCard(
                                      transaction: state.transactions[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                        height: constants.tenVertical);
                                  },
                                )),
                    ],
                  ),
                );
              } else {
                context.read<TransactionsBloc>().add(LoadFilteredTransactions(
                    DateTime.now(), FirebaseAuth.instance.currentUser!.uid));
                return Container();
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
        child: const Icon(
          Icons.add_rounded,
          size: 26,
        ),
      ),
    );
  }
}
