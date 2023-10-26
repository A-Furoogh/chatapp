// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:chatapp/services/chat_services.dart';
import 'package:equatable/equatable.dart';
import 'package:chatapp/models/chat.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {

  final ChatService _chatService;

  ChatsBloc(this._chatService) : super(ChatsLoadingState()) {

    on<LoadChatsEvent>((event, emit) async {
      emit(ChatsLoadingState());
      print("emitted the first state from chat");
      try {
        final chats = await _chatService.getChats();
        emit(ChatsLoadedState(chats));
      } catch (e) {
        emit(ChatsErrorState(e.toString()));
      }
    });
  }
}
