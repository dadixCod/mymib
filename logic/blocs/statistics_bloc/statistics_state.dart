part of 'statistics_bloc.dart';

class StatisticsState {
  final Map<String, double> revenuesStatistics;
  final Map<String, double> expensesStatistics;
  const StatisticsState(this.revenuesStatistics, this.expensesStatistics);
}

final class StatisticsInitial extends StatisticsState {
  StatisticsInitial() : super({}, {});
}
