// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/generated/l10n.dart';
import 'package:mymib/logic/blocs/date_bloc.dart/bloc/date_bloc.dart';
import 'package:mymib/logic/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_event.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_state.dart';
import 'package:mymib/logic/blocs/user_bloc/user_bloc.dart';
import 'package:mymib/logic/blocs/user_bloc/user_event.dart';
import 'package:mymib/logic/blocs/user_bloc/user_state.dart';
import 'package:mymib/presentation/widgets/statistics_view.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Set<String> selected = {};
  DateTime? selectedDate;
  var transactionsLoading = false;
  var userLoading = false;
  String type = '';

  @override
  void initState() {
    selectedDate = DateTime.now();
    context.read<TransactionsBloc>().add(LoadFilteredTransactions(
        selectedDate!, FirebaseAuth.instance.currentUser!.uid));
    context.read<UserBloc>().add(LoadUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;
    final autoTexts = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          autoTexts.stats,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
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
                setState(() {
                  selected = {};
                });
              }
              return;
            },
            icon: const Icon(Icons.date_range),
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            type = state.user.type!;
            userLoading = false;
          } else if (state is LoadingUser) {
            setState(() {
              userLoading = state.isLoading;
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
              if (state is TransactionLoading || userLoading) {
                return Center(
                  child:
                      SpinKitFadingCircle(color: context.colorScheme.primary),
                );
              } else if (state is TransactionsLoaded) {
                double revenuesTotal = 0;
                double expensesTotal = 0;
                final transactions = state.transactions;
                context
                    .read<StatisticsBloc>()
                    .add(CalculateStatistics(transactions));
                for (var tr in transactions) {
                  revenuesTotal += tr.revenueAmount ?? 0;
                  expensesTotal += tr.expenseAmount ?? 0;
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: deviseSize.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: SegmentedButton(
                          emptySelectionAllowed: true,
                          onSelectionChanged: (newSelection) {
                            setState(() {
                              selected = newSelection;
                              if (newSelection.isNotEmpty) {
                                if (newSelection.first == '1') {
                                  context.read<DateBloc>().add(SelectDateRange(
                                        startDate: DateTime.now()
                                            .subtract(const Duration(days: 7)),
                                        endDate: DateTime.now(),
                                      ));
                                } else if (newSelection.first == '2') {
                                  context.read<DateBloc>().add(SelectDateRange(
                                        startDate: DateTime.now()
                                            .subtract(const Duration(days: 30)),
                                        endDate: DateTime.now(),
                                      ));
                                } else if (newSelection.first == '3') {
                                  context.read<DateBloc>().add(SelectDateRange(
                                        startDate: DateTime.now().subtract(
                                            const Duration(days: 365)),
                                        endDate: DateTime.now(),
                                      ));
                                }
                              }
                              selectedDate = null;
                            });
                          },
                          segments: [
                            ButtonSegment(
                              value: '1',
                              label: Text(
                                autoTexts.weekly,
                              ),
                            ),
                            ButtonSegment(
                              value: '2',
                              label: Text(
                                autoTexts.monthly,
                              ),
                            ),
                            ButtonSegment(
                              value: '3',
                              label: Text(
                                autoTexts.yearly,
                              ),
                            ),
                          ],
                          selected: selected,
                        ),
                      ),
                      BlocBuilder<StatisticsBloc, StatisticsState>(
                        builder: (context, state) {
                          return DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(
                                  tabs: [
                                    Tab(
                                      text: type == 'individual'
                                          ? '${autoTexts.individualRevenues} $revenuesTotal ${autoTexts.currency}'
                                          : '${autoTexts.companyRevenues} $revenuesTotal ${autoTexts.currency}',
                                    ),
                                    Tab(
                                      text: type == 'individual'
                                          ? '${autoTexts.individualExpenses} $expensesTotal ${autoTexts.currency}'
                                          : '${autoTexts.companyExpenses} $expensesTotal ${autoTexts.currency}',
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: deviseSize.height * 0.8,
                                  child:
                                      revenuesTotal == 0 && expensesTotal == 0
                                          ? EmptyTransactions(
                                              deviseSize: deviseSize,
                                              autoTexts: autoTexts)
                                          : TabBarView(
                                              children: [
                                                revenuesTotal == 0
                                                    ? EmptyTransactions(
                                                        deviseSize: deviseSize,
                                                        autoTexts: autoTexts)
                                                    : StatisticsView(
                                                        deviseSize: deviseSize,
                                                        categories: state
                                                            .revenuesStatistics,
                                                        isExpensesList: false,
                                                        amount: revenuesTotal,
                                                      ),
                                                expensesTotal == 0
                                                    ? EmptyTransactions(
                                                        deviseSize: deviseSize,
                                                        autoTexts: autoTexts)
                                                    : StatisticsView(
                                                        deviseSize: deviseSize,
                                                        categories: state
                                                            .expensesStatistics,
                                                        isExpensesList: true,
                                                        amount: expensesTotal,
                                                      ),
                                              ],
                                            ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({
    super.key,
    required this.deviseSize,
    required this.autoTexts,
  });

  final Size deviseSize;
  final S autoTexts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviseSize.height * 0.4,
      width: deviseSize.width * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/add_data.png',
              height: deviseSize.height * 0.35,
            ),
            SizedBox(
              height: deviseSize.height * 0.02,
            ),
            Text(
              autoTexts.noTransactions,
            )
          ],
        ),
      ),
    );
  }
}
