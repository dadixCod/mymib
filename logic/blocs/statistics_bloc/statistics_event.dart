part of 'statistics_bloc.dart';

abstract class StatisticsEvent {}

class CalculateStatistics extends StatisticsEvent {
  final List<Transaction> transactions;
  CalculateStatistics(this.transactions);
}
