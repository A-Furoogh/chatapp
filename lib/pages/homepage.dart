import 'package:chatapp/pages/chat.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Chat> _chats = [
    const Chat(chatId: 1212),
    const Chat(chatId: 1313),
    const Chat(chatId: 1414,),
    const Chat(chatId: 1515,)
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 208, 211, 218), Color.fromARGB(255, 157, 196, 219)],
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Willkomen bei Keywaa',
              style: TextStyle(fontSize: 30),),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/qr_scan'),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.blue[800],
                  elevation: 10,
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
                          icon: const Icon(Icons.qr_code_2,size: 50,), 
                          label: const Text('QR-Code scannen'))
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                elevation: 10,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox( height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Weiter chatten',
                        style: TextStyle(fontSize: 24, color: Colors.white),),
                  
                        Expanded(
                          child: ListView.builder(
                            itemCount: _chats.length,
                            itemBuilder: (context, index) {
                              final chat = _chats[index];
                              return Card(color: index % 2 == 0 ? Colors.lightGreen[100] : Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black38, width: 3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  title: Text('Chat ID: ${chat.chatId}', 
                                              style: const TextStyle(fontSize: 18, 
                                                    fontWeight: FontWeight.bold),),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Chat(chatId: chat.chatId)),
                                      );
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 80),
                    Text('Reimedia GmbH', style: TextStyle(fontSize: 18)),
                    Text('Amtsstr. 25a, 59073 Hamm'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

