// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/services/user_services.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserService _userService;

  UsersBloc(this._userService) : super(UsersLoadingState()) {

    on<LoadUsersEvent>((event, emit) async {
      emit(UsersLoadingState());
      print("emitted the first state");
      try {
        final users = await _userService.getUsers();
        emit(UsersLoadedState(users));
      } catch (e) {
        emit(UsersErrorState(e.toString()));
      }
    });

    on<AddUserEvent>(_onAddUser);
    on<DeleteUserEvent>(_onDeleteUser);

  }

  void _onAddUser(AddUserEvent event, Emitter<UsersState> emit) {}

  void _onDeleteUser(DeleteUserEvent event, Emitter<UsersState> emit) {}
}
