part of './date_bloc.dart';


class DateEvent {
  
}

class SelectOneDate extends DateEvent{
final DateTime date;
  
   SelectOneDate({required this.date});
}

class SelectDateRange extends DateEvent {
  final DateTime startDate;
  final DateTime endDate;

  SelectDateRange({required this.startDate, required this.endDate});
}
