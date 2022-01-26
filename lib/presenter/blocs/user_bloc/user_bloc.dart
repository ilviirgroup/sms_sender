import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sms_sender/entity/models/user.dart';
import 'package:sms_sender/entity/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserFetched>(_onUserFetched);
  }

  Future<void> _onUserFetched(
      UserFetched event, Emitter<UserState> emit) async {
    List<User> user = await UserRepository().getData;
    emit(UserFetchSuccess(user.first));
  }
}
