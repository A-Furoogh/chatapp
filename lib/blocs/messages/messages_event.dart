part of 'messages_bloc.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}
class LoadMessagesEvent extends MessagesEvent {
  final List<Message> messages;

  const LoadMessagesEvent({this.messages = const <Message>[]});

  @override
  List<Object> get props => [messages];
}

class AddMessageEvent extends MessagesEvent {
  final Message message;

  const AddMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteMessageEvent extends MessagesEvent {
  final Message message;

  const DeleteMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateMessageEvent extends MessagesEvent {
  final Message message;

  const UpdateMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadChatMessagesEvent extends MessagesEvent {
  final int chatId;

  const LoadChatMessagesEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}

class ClearMessagesEvent extends MessagesEvent {
  const ClearMessagesEvent();

  @override
  List<Object> get props => [];
}

class ClearChatMessagesEvent extends MessagesEvent {
  const ClearChatMessagesEvent();

  @override
  List<Object> get props => [];
}
