import 'package:chatapp/models/message.dart';

class Chat {
  final String chatId;
  List<Message>? messages;

  Chat({required this.chatId, this.messages});

  factory Chat.fromJson(Map<String, dynamic> json) {
    var list = json['messages'] as List;
    List<Message> messageList = list.map((i) => Message.fromJson(i)).toList();

    return Chat(
      chatId: json['chatId'],
      messages: messageList
      );
  }

  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'messages': messages!.map((e) => e.toJson()).toList()
  };
}