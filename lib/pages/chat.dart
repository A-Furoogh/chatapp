import 'package:flutter/material.dart';

class Chat extends StatelessWidget {

  final String child;

  const Chat({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 200,
        color: Colors.deepPurple[100],
        child: Center(
          child: Text(
            child,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),

    );
  }
}