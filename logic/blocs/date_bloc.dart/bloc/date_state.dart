part of './date_bloc.dart';

class DateState {
  final DateTime date;
  const DateState({required this.date});
}

class InitialDate extends DateState {
  InitialDate() : super(date: DateTime.now());
}
class DateRangeState extends DateState {
  final DateTime startDate;
  final DateTime endDate;

  DateRangeState({required this.startDate, required this.endDate})
      : super(date: startDate); 

  
}
