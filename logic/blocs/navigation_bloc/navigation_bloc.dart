import 'package:flutter_bloc/flutter_bloc.dart';
part './navigation_event.dart';
part './navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(InitialNavigationPage()) {
    on<PageChanged>((event, emit) {
      emit(state.copyWith(pageIndex: event.pageIndex));
    });
  }
}
