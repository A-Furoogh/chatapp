import 'package:bloc/bloc.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/services/chat_services.dart';
import 'package:equatable/equatable.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {

  final ChatService _chatService;
  final int _chatId;

  MessagesBloc(this._chatService, this._chatId) : super(MessagesLoadingState()) {
    on<MessagesEvent>((event, emit) {
      if (event is LoadChatMessagesEvent) {
        _loadChatMessages(event, emit);
      } else if (event is AddMessageEvent) {
        _addMessage(event, emit);
      } else if (event is DeleteMessageEvent) {
        _deleteMessage(event, emit);
      } else if (event is UpdateMessageEvent) {
        _updateMessage(event, emit);
      } else if (event is ClearMessagesEvent) {
        _clearMessages(event, emit);
      }
    });

    on<LoadChatMessagesEvent>(_loadChatMessages);
    on<AddMessageEvent>(_addMessage);
    on<DeleteMessageEvent>(_deleteMessage);
    on<UpdateMessageEvent>(_updateMessage);
    on<ClearMessagesEvent>(_clearMessages);

    add(LoadChatMessagesEvent(_chatId));
    }

  void _loadChatMessages(LoadChatMessagesEvent event, Emitter<MessagesState> emit) async {

    emit(MessagesLoadingState());

    try {
      final messages = await _chatService.getChatMessages(event.chatId);
      emit(MessagesLoadedState(messages));
    } catch (e) {
      emit(MessagesErrorState(e.toString()));
    }
  }

  void _addMessage(AddMessageEvent event, Emitter<MessagesState> emit) async {

    emit(MessagesLoadingState());

    try {
      await _chatService.addMessage(event.message, _chatId);
      final messages = await _chatService.getChatMessages(_chatId);
      emit(MessagesLoadedState(messages));
    } catch (e) {
      emit(MessagesErrorState(e.toString()));
    }

  }

  void _deleteMessage(DeleteMessageEvent event, Emitter<MessagesState> emit) async {
      
      emit(MessagesLoadingState());
  
      try {
        await _chatService.deleteMessage(_chatId, event.message.messageId);
        final messages = await _chatService.getChatMessages(_chatId);
        emit(MessagesLoadedState(messages));
      } catch (e) {
        emit(MessagesErrorState(e.toString()));
      }
  }

  void _updateMessage(UpdateMessageEvent event, Emitter<MessagesState> emit) async {

    emit(MessagesLoadingState());

    try {
      await _chatService.updateMessage(event.message);
      final messages = await _chatService.getChatMessages(_chatId);
      emit(MessagesLoadedState(messages));
    } catch (e) {
      emit(MessagesErrorState(e.toString()));
    }

  }

  void _clearMessages(ClearMessagesEvent event, Emitter<MessagesState> emit) async {

    emit(MessagesLoadingState());

    try {
      await _chatService.clearMessages();
      final messages = await _chatService.getChatMessages(_chatId);
      emit(MessagesLoadedState(messages));
    } catch (e) {
      emit(MessagesErrorState(e.toString()));
    }

  }

}
