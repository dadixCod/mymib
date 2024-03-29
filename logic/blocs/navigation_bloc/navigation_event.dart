part of 'navigation_bloc.dart';

abstract class NavigationEvent {}

class PageChanged extends NavigationEvent {
  final int pageIndex;
  PageChanged({required this.pageIndex});
}
