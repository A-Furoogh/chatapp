part of 'chats_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class LoadChatsEvent extends ChatsEvent {
  final List<Chat> chats;

  const LoadChatsEvent({this.chats = const <Chat>[]});

  @override
  List<Object> get props => [];
}

class AddChatEvent extends ChatsEvent {
  final Chat chat;

  const AddChatEvent({required this.chat});

  @override
  List<Object> get props => [chat];
}

class DeleteChatEvent extends ChatsEvent {
  final Chat chat;

  const DeleteChatEvent({required this.chat});

  @override
  List<Object> get props => [chat];
}

class UpdateChatEvent extends ChatsEvent {
  final Chat chat;

  const UpdateChatEvent({required this.chat});

  @override
  List<Object> get props => [chat];
}

class LoadChatMessagesEvent extends ChatsEvent {
  final int chatId;

  const LoadChatMessagesEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}
