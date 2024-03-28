import 'package:mymib/data/models/user_model.dart';

class UserState {
  const UserState();
}
class UserInitState extends UserState{}

class UserLoaded extends UserState {
  final UserModel user;
  const UserLoaded(this.user);
}

class LoadingUser extends UserState {
  final bool isLoading;
  LoadingUser({required this.isLoading});
}

class FailedUserLoading extends UserState {
  final String errorMessage;
  const FailedUserLoading(this.errorMessage);
}
