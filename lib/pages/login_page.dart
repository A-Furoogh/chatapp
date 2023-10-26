import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _email = TextEditingController();
  final _passwort = TextEditingController();

  void submitLogin() {
    	if(_email.text != '' && _passwort.text != ''){
        
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
  }

  final snackBar = const SnackBar(
    content: Text('Ein Feld ist noch leer !')
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text('anmelden'),centerTitle: true, ),
        body: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('E-Mail:', style: TextStyle(fontSize: 24),),
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'Email eingeben',
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _email.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('Passwort:', style: TextStyle(fontSize: 24),),
                  TextFormField(
                    controller: _passwort,
                    decoration: InputDecoration(
                      hintText: 'Email eingeben',
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _passwort.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: submitLogin,
                    icon: const Icon(Icons.login),
                    label: const Text('anmelden'),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}