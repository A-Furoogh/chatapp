part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsersEvent extends UsersEvent {
  final List<User> users;

  const LoadUsersEvent({this.users = const <User>[]});

  @override
  List<Object> get props => [];
}

class AddUserEvent extends UsersEvent {
  final User user;

  const AddUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class DeleteUserEvent extends UsersEvent {
  final User user;

  const DeleteUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}