part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserFetched extends UserEvent {}
