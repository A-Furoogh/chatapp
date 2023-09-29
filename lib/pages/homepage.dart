import 'package:chatapp/pages/chat.dart';
import 'package:chatapp/pages/qr_code_scann.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List _chats = [
    'Erster Chat',
    'Zweiter Chat',
    'Dritter Chat',
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Keywaa chat app'),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50]
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Willkomen bei Keywaa',
              style: TextStyle(fontSize: 30),),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[900],
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Haben Sie etwas gefunden und möchten es zurückgeben?',
                      style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                      const SizedBox(height: 9),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/qr_scan');
                        }, 
                        icon: const Icon(Icons.qr_code,size: 50,), 
                        label: const Text('QR-Code scannen'))
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Weiter chatten',
                      style: TextStyle(fontSize: 20, color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

