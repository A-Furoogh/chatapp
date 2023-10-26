part of 'messages_bloc.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();
  
  @override
  List<Object> get props => [];
}

final class MessagesLoadingState extends MessagesState {
  @override
  List<Object> get props => [];
}

final class MessagesLoadedState extends MessagesState {
  final List<Message> messages;

  const MessagesLoadedState(this.messages);

  @override
  List<Object> get props => [messages];
}

final class MessagesErrorState extends MessagesState {
  final String error;

  const MessagesErrorState(this.error);

  @override
  List<Object> get props => [error];
}

