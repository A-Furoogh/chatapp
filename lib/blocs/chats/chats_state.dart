part of 'chats_bloc.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();
  
  @override
  List<Object> get props => [];
}

final class ChatsLoadingState extends ChatsState {
  @override
  List<Object> get props => [];
}

final class ChatsLoadedState extends ChatsState {
  final List<Chat> chats;

  const ChatsLoadedState(this.chats);

  @override
  List<Object> get props => [chats];
}

final class ChatsErrorState extends ChatsState {
  final String error;

  const ChatsErrorState(this.error);

  @override
  List<Object> get props => [error];
}

