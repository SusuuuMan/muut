import 'package:chaljaabhai/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.title});
  final String title;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                    ),
                    TextField(
                      obscureText: true,
                      controller: _password,
                    ),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final pass = _password.text;
                        try {
                          final userCredentials = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: pass);
                          print(userCredentials);
                        } on FirebaseAuthException catch (e) {
                          print(e.code);
                          if (e.code == "invalid-email") {
                            print("invalid-email format ");
                          } else if (e.code == "weak-password") {
                            print("weak-password - goku");
                          } else if (e.code == "email-already-in-use") {
                            print("Already in usseeee");
                          }
                        } catch (e) {}
                      },
                      child: Text("Register"),
                    ),
                  ],
                );

              default:
                return Text("loading.....");
            }
          }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
