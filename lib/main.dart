import 'package:chatapp/pages/chat.dart';
import 'package:chatapp/pages/homepage.dart';
import 'package:chatapp/pages/qr_code_scann.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home':(context) => HomePage(),
        '/qr_scan':(context) => const QRCodeScan(),
        '/chat_Seite':(context) => const Chat(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Keywaa',
      home: HomePage(),
    );
  }
}
