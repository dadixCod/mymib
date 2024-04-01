import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mymib/core/utils/extensions.dart';
import 'package:mymib/logic/blocs/date_bloc.dart/bloc/date_bloc.dart';
import 'package:mymib/logic/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_event.dart';
import 'package:mymib/logic/blocs/transactions_bloc/transactions_state.dart';
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

  @override
  void initState() {
    selectedDate = DateTime.now();
    context.read<TransactionsBloc>().add(LoadFilteredTransactions(
        selectedDate!, FirebaseAuth.instance.currentUser!.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviseSize = context.deviceSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistiques',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
            children: [
              selectedDate == null
                  ? const SizedBox()
                  : Text(
                      DateFormat.Md().format(selectedDate!),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              IconButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(
                      const Duration(days: 3650),
                    ),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      selected = {};
                      selectedDate = date;
                      context.read<DateBloc>().add(SelectOneDate(date: date));
                    });
                  }
                  return;
                },
                icon: const Icon(
                  Icons.calendar_month,
                ),
              ),
            ],
          )
        ],
      ),
      body: BlocConsumer<TransactionsBloc, TransactionState>(
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
              child: SpinKitFadingCircle(color: context.colorScheme.primary),
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
                                  startDate: DateTime.now()
                                      .subtract(const Duration(days: 365)),
                                  endDate: DateTime.now(),
                                ));
                          }
                          selectedDate = null;
                        });
                      },
                      segments: const [
                        ButtonSegment(
                          value: '1',
                          label: Text(
                            'Semaine',
                          ),
                        ),
                        ButtonSegment(
                          value: '2',
                          label: Text(
                            'Mois',
                          ),
                        ),
                        ButtonSegment(
                          value: '3',
                          label: Text(
                            'Année',
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
                                Tab(text: 'Revenus $revenuesTotal DA'),
                                Tab(text: 'Dépenses $expensesTotal DA'),
                              ],
                            ),
                            SizedBox(
                              height: deviseSize.height * 0.8,
                              child: revenuesTotal == 0 || expensesTotal == 0
                                  ? SizedBox(
                                      height: deviseSize.height * 0.4,
                                      width: deviseSize.width * 0.8,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/add_data.png',
                                            ),
                                            SizedBox(
                                              height: deviseSize.height * 0.02,
                                            ),
                                            const Text(
                                              'Aucune transaction ce jour-là.',
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : TabBarView(
                                      children: [
                                        StatisticsView(
                                          deviseSize: deviseSize,
                                          categories: state.revenuesStatistics,
                                          isExpensesList: false,
                                          amount: revenuesTotal,
                                        ),
                                        StatisticsView(
                                          deviseSize: deviseSize,
                                          categories: state.expensesStatistics,
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
      ),
    );
  }
}
