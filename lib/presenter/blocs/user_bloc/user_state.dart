part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserFetchSuccess extends UserState {
  final User user;
  UserFetchSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
