import 'package:flutter_bloc/flutter_bloc.dart';
part './date_event.dart';
part './date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  Stream<DateState> get date => stream;
  DateBloc() : super(InitialDate()) {
    on<SelectOneDate>((event, emit) {
      emit(DateState(date: event.date));
    });
    on<SelectDateRange>(
      (event, emit) {
        emit(
            DateRangeState(startDate: event.startDate, endDate: event.endDate));
      },
    );
  }
}
