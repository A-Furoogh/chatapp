import 'dart:io';

import 'package:chatapp/blocs/chats/chats_bloc.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/pages/chat_page/message_widget.dart';
import 'package:chatapp/pages/loading_indicator.dart';
import 'package:chatapp/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final int chatId;
  const ChatPage({super.key, required this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  // Instance of ChatService from the bloc provider
  late final ChatService _chatService =
      RepositoryProvider.of<ChatService>(context);

  void _sendMessage() async {
    if (_textController.text.isNotEmpty) {
      final message = Message(
        text: _textController.text,
        date: DateTime.now(),
        isSentByMe: true,
        isSeen: false,
        messageId: await _chatService.generateMessageId(widget.chatId),
      );
      setState(() {
        // Add the message to the list of messages
        _chatService.addMessage(message, widget.chatId);
        // Clear the text field
        _textController.clear();
      });
    }
  }

  Future<void> _sendImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quelle für Bild auswählen'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    _processImage(pickedFile);
                  },
                  label: const Text('Kamera'),
                  icon: const Icon(Icons.camera_alt),
                ),
                TextButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      _processImage(pickedFile);
                    },
                    label: const Text('Galerie'),
                    icon: const Icon(Icons.photo_library)),
              ],
            ),
          ],
        );
      },
    );
  }

  void _processImage(XFile? pickedFile) {
    if (pickedFile != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController textController = TextEditingController();
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text('Fügen Sie Ihre Nachricht'),
            content: SizedBox(
              height: 300,
              child: Column(
                children: [
                  Image.file(
                    File(pickedFile.path),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        labelText: 'Ihre nachricht...',
                        filled: true,
                        fillColor: Colors.grey[300]),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Abbrechen'),
              ),
              TextButton(
                onPressed: () async {
                  final message = Message(
                    text: textController.text,
                    date: DateTime.now(),
                    isSentByMe: true,
                    imagePath: pickedFile.path,
                    isSeen: false,
                    messageId:
                        await _chatService.generateMessageId(widget.chatId),
                  );
                  setState(() {
                    // Add the message to the list of messages
                    _chatService.addMessage(message, widget.chatId);
                    // Clear the text field
                    _textController.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Senden'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _showImageDialog(String imagePath) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.file(
            File(imagePath),
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

  //List<Message> messages = [
  /*Message(
      text: 'Hi Wie gehts dir?',
      date:  DateTime.now().subtract(const Duration(days: 5, minutes: 2)),
      isSentByMe: false,
    ),
    Message(
      text: 'gut, und dir?',
      date:  DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: true,
      isSeen: true,
    ),
    Message(
      text: 'Ich habe deine Tasche gefunden',
      date:  DateTime.now().subtract(const Duration(days: 3, minutes: 5)),
      isSentByMe: false,
    ),
    Message(
      text: 'schicke das bitte an meine Addresse',
      date:  DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
      isSentByMe: true,
      isSeen: true,
    ),
    Message(
      text: 'Wo wohnst du?',
      date:  DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: false,
    )
  ].toList();     // reversed.toList();
*/
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatsBloc>(
      create: (context) => ChatsBloc(
        RepositoryProvider.of<ChatService>(context),
      )..add(const LoadChatsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat App'),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            image: const DecorationImage(
                image: AssetImage("assets/images/chat_background.png"),
                fit: BoxFit.cover,
                opacity: 0.7),
          ),
          child: BlocBuilder<ChatsBloc, ChatsState>(
            builder: (context, state) {
              if (state is ChatsLoadingState) {
                return const Center(
                  child: LoadingIndicator(),
                );
              }
              if (state is ChatsLoadedState) {
                // Get the messages from the state
                final messages = state.chats
                    .firstWhere((chat) => chat.chatId == widget.chatId)
                    .messages;
                if (messages!.isEmpty) {
                  return const Center(
                    child: Text('Keine Nachrichten'),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: GroupedListView<Message, DateTime>(
                        padding: const EdgeInsets.all(8),
                        reverse: true,
                        order: GroupedListOrder.DESC,
                        useStickyGroupSeparators: true,
                        floatingHeader: true,
                        elements: messages,
                        groupBy: (message) => DateTime(
                          message.date.year,
                          message.date.month,
                          message.date.day,
                        ),
                        groupHeaderBuilder: (Message message) => SizedBox(
                          height: 40,
                          child: Center(
                            child: Card(
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  DateFormat('d.MMM.y').format(message
                                      .date), // DateFormat.yMMMd().format
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemBuilder: (context, Message message) => Align(
                          alignment: message.isSentByMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              if (message.imagePath.isNotEmpty) {
                                _showImageDialog(message.imagePath);
                              }
                            },
                            child: MyMessageWidget(message: message),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(12),
                                  hintText: 'Nachricht schreiben...',
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide:
                                        BorderSide(color: Colors.white54),
                                  )),
                              controller: _textController,
                              onChanged: (text) {
                                setState(() {});
                              },
                              onSubmitted: (value) => _sendMessage(),
                            ),
                          ),
                          _textController.text.isEmpty
                              ? IconButton(
                                  onPressed: _sendImage,
                                  icon: Icon(
                                    Icons.photo,
                                    color: Colors.blue[900],
                                    size: 35,
                                    shadows: const [
                                      Shadow(
                                        color: Color.fromARGB(115, 41, 36, 36),
                                        blurRadius: 15,
                                      )
                                    ],
                                  ))
                              : IconButton(
                                  onPressed: _sendMessage,
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.blue[900],
                                    size: 35,
                                  ))
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
