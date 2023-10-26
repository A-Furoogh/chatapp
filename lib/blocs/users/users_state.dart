part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object> get props => [];
}

final class UsersLoadingState extends UsersState {
  @override
  List<Object> get props => [];
}

final class UsersLoadedState extends UsersState {
  final List<User> users;

  const UsersLoadedState(this.users);

  @override
  List<Object> get props => [users];
}

final class UsersErrorState extends UsersState {
  final String error;

  const UsersErrorState(this.error);

  @override
  List<Object> get props => [error];
}