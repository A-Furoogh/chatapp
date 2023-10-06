import 'dart:io';

import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {

  final int? chatId;
  const Chat({super.key, this.chatId});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final TextEditingController _textController = TextEditingController();

  void _sendMessage(){
    final message = Message(
                  text: _textController.text,
                  date: DateTime.now(),
                  isSentByMe: true,
                );
    setState(() {
      messages.add(message);
      _textController.clear();
    });
  }

  Future<void> _sendPhoto() async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Quelle für Bild auswählen'),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  _processImage(pickedFile);
                },
                label: const Text('Kamera'),
                icon: const Icon(Icons.camera_alt),
              ),
              TextButton.icon(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  _processImage(pickedFile);
                },
                label: const Text('Galerie'),
                icon: const Icon(Icons.photo_library)
              ),
            ],
          ),
        ],
      );
    },
  );
}

  void _processImage(XFile? pickedFile) {
  if (pickedFile != null) {
    final message = Message(
      text: '',
      date: DateTime.now(),
      isSentByMe: true,
      imagePath: pickedFile.path,
    );

    setState(() {
      messages.add(message);
    });
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

  List<Message> messages = [
    Message(
      text: 'Hi Wie gehts dir?',
      date:  DateTime.now().subtract(const Duration(days: 5, minutes: 2)),
      isSentByMe: false,
    ),
    Message(
      text: 'gut, und dir?',
      date:  DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: true,
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
    ),
    Message(
      text: 'Wo wohnst du?',
      date:  DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: false,
    )
  ].toList();     // reversed.toList();

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
                        DateFormat('d.MMM.y').format(message.date), // DateFormat.yMMMd().format
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                      ? Alignment.centerRight : Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    if (message.imagePath.isNotEmpty) {
                      _showImageDialog(message.imagePath);
                    }
                  },
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: message.imagePath.isNotEmpty
                          ? Image.file(
                            File(message.imagePath),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover)
                          : Text(message.text),
                    ),
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
                    onChanged: (text) {
                      setState(() {
                        
                      });
                    },
                    onSubmitted: (value) => 
                      _sendMessage(),
                  ),
                ),
                _textController.text.isEmpty
                  ? IconButton(
                    onPressed: _sendPhoto, 
                    icon: const Icon(Icons.photo))
                  : IconButton(
                    onPressed: _sendMessage, 
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}