part of 'navigation_bloc.dart';
class NavigationState {
  final int pageIndex;
  const NavigationState({required this.pageIndex});

  NavigationState copyWith({required int? pageIndex}) {
    return NavigationState(pageIndex:  pageIndex ?? this.pageIndex);
  }
}

class InitialNavigationPage extends NavigationState {
  InitialNavigationPage() : super(pageIndex: 0);
}
