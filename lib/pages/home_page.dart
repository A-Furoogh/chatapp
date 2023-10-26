import 'package:chatapp/blocs/chats/chats_bloc.dart';
import 'package:chatapp/blocs/users/users_bloc.dart';
import 'package:chatapp/models/chat.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/pages/chat_page/chat_page.dart';
import 'package:chatapp/pages/loading_indicator.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/qr_code_scann_page.dart';
import 'package:chatapp/services/chat_services.dart';
import 'package:chatapp/services/user_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoggedIn = true;

  void logOut() {}

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (context) => UsersBloc(
            RepositoryProvider.of<UserService>(context),
          )..add(LoadUsersEvent()),
        ),
        BlocProvider<ChatsBloc>(
            create: (context) => ChatsBloc(
                  RepositoryProvider.of<ChatService>(context),
                )..add(LoadChatsEvent())),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: const Text('Keywaa chat app'),
          centerTitle: true,
          actions: [
            isLoggedIn
                ? PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'logout') {
                        setState(() {
                          isLoggedIn = false;
                        });
                      }
                    },
                    itemBuilder: (context) {
                      return <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'logout',
                          child: Text('Abmelden'),
                        )
                      ];
                    },
                    icon: const Icon(Icons.logout_outlined))
                : IconButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login())),
                    icon: const Icon(CupertinoIcons.person_crop_circle))
          ],
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoadingState) {
              return const Center(
                child: LoadingIndicator(),
              );
            }
            if (state is UsersLoadedState) {
              List<User> userList = state.users;
              print(userList.asMap());
              return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 208, 211, 218),
                    Color.fromARGB(255, 157, 196, 219)
                  ],
                )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Willkomen bei Keywaa',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const QRCodeScanPage()),
                                      ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blue[800],
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Haben Sie etwas gefunden und möchten es zurückgeben?',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 9),
                                ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const QRCodeScanPage()),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.qr_code_2,
                                      size: 50,
                                    ),
                                    label: const Text('QR-Code scannen'))
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 10,
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 200,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Weiter chatten',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                BlocBuilder<ChatsBloc, ChatsState>(
                                    builder: (context, state) {
                                  if (state is ChatsLoadingState) {
                                    return Center(child: Text("Chats Loading"));
                                  }
                                  if (state is ChatsLoadedState) {
                                    List<Chat> chatList = state.chats;
                                    print(chatList.asMap());
                                    return Expanded(
                                      child: ListView.builder(
                                        itemCount: chatList.length,
                                        itemBuilder: (context, index) {
                                          final chat = chatList[index];
                                          return Card(
                                            color: index % 2 == 0
                                                ? Colors.lightGreen[100]
                                                : Colors.grey[100],
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.black38,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                'Chat ID: ${chat.chatId}',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onTap: () {
                                                //ChatPage chatPage = ChatPage(chatId: chat.chatId as int,);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>ChatPage(chatId: int.parse(chat.chatId))),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  if (state is ChatsErrorState) {
                                    return Center(
                                      child: Text("Fehler Fehler"),
                                    );
                                  } else {
                                    return Center(child: Text("Einige Fehler"));
                                  }
                                })
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (_, index) {
                            return Card(
                              color: Colors.blue,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(
                                  userList[index].userId,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 80),
                            Text('Reimedia GmbH',
                                style: TextStyle(fontSize: 18)),
                            Text('Amtsstr. 25a, 59073 Hamm'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is UsersErrorState) {
              return const Center(
                child: Text("Fehler"),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
