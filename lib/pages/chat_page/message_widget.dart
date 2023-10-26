import 'dart:io';

import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';

class MyMessageWidget extends StatefulWidget {

  final Message message;
  const MyMessageWidget({super.key, required this.message});

  @override
  State<MyMessageWidget> createState() => _MyMessageWidgetState();
}

class _MyMessageWidgetState extends State<MyMessageWidget> {

  @override
  Widget build(BuildContext context) {
    
    Message message = widget.message;

    return Card(
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, message.isSentByMe ? 2 : 12),
              child: message.imagePath.isNotEmpty
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.file(
                        File(message.imagePath),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover),
                        const SizedBox(height: 5),
                        Text(message.text, style: const TextStyle(fontSize: 18)),
                        if(message.isSentByMe)
                        message.isSeen 
                            ? const Icon(Icons.check_rounded, color: Colors.blue, size: 20,) 
                            : const Icon(Icons.check_rounded, size: 20, color: Colors.grey,)
                    ],
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(message.text),
                      if(message.isSentByMe)
                      message.isSeen 
                            ? const Icon(Icons.check_rounded, color: Colors.blue, size: 20,) 
                            : const Icon(Icons.check_rounded, size: 20, color: Colors.grey,)
                    ],
                  ),
            ),
          );
  }
}