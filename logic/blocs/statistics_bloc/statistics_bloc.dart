import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mymib/data/models/transaction.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  Map<String, double> _calculateCategoryStatistics(
    List<Transaction> transactions,
    String Function(Transaction) getCategory,
    double Function(Transaction) getAmount,
  ) {
    Map<String, double> categoryStatistics = {};
    for (var transaction in transactions) {
      String category = getCategory(transaction);
      double amount = getAmount(transaction);

      if (!categoryStatistics.containsKey(category)) {
        categoryStatistics[category] = 0;
      }
      categoryStatistics[category] =
          (categoryStatistics[category] ?? 0) + amount;
    }

    return categoryStatistics;
  }

  StatisticsBloc() : super(StatisticsInitial()) {
    on<CalculateStatistics>((event, emit) async {
      Map<String, double> revenuesStatistics = _calculateCategoryStatistics(
        event.transactions,
        (transaction) => transaction.revenueCategory,
        (transaction) => transaction.revenueAmount ?? 0,
      );
      Map<String, double> expensesStatistics = _calculateCategoryStatistics(
        event.transactions,
        (transaction) => transaction.expenseCategory,
        (transaction) => transaction.expenseAmount ?? 0,
      );

      emit(StatisticsState(revenuesStatistics, expensesStatistics));
    });
  }
}
