import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {


  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  TextEditingController _textController = TextEditingController();
  void _sendMessage(){
    final message = Message(
                  text: _textController.text,
                  date: DateTime.now(),
                  isSentByMe: true,
                );
    setState(() {
      messages.add(message);
      _textController = null;
    });
  }

  List<Message> messages = [
    Message(
      text: 'Hi Wie gehts dir?',
      date:  DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'gut, und dir?',
      date:  DateTime.now().subtract(const Duration(days: 4, minutes: 4)),
      isSentByMe: true,
    ),
    Message(
      text: 'Ich habe deine Tasche gefunden',
      date:  DateTime.now().subtract(const Duration(days: 3, minutes: 5)),
      isSentByMe: false,
    ),
    Message(
      text: 'schicke das bitte an meine Addresse',
      date:  DateTime.now().subtract(const Duration(days: 2, minutes: 3)),
      isSentByMe: true,
    ),
    Message(
      text: 'Wo wohnst du?',
      date:  DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: false,
    )
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
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
                        DateFormat.yMMMd().format(message.date),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                      ? Alignment.centerRight : Alignment.centerLeft,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(message.text),
                  ),
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
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Nachricht schreiben...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(color: Colors.white54),
                      )
                    ),
                    controller: _textController,
                    onSubmitted: (text) {
                      
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _sendMessage();
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}