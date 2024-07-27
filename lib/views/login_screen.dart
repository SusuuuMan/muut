import 'package:chaljaabhai/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
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
                            .signInWithEmailAndPassword(
                                email: email, password: pass);
                        print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
                        print(userCredentials);
                      } on FirebaseAuthException catch (e) {
                        print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                        print(e.code);
                        print(e.credential);
                        print("fffffffffffffffffffffffffffffffffffffffffffff");
                        print(e.email);
                        print(e.phoneNumber);
                        if (e.code == "invalid-credential") {
                          try {
                            // final u = await FirebaseAuth.instance
                            //     .createUserWithEmailAndPassword(
                            //         email: email, password: pass);
                            // print(u);
                            final u = await FirebaseAuth.instance
                                .fetchSignInMethodsForEmail(email);
                            print(u);
                            print("llllllllllllllllllllllllllllllll");
                          } catch (e) {
                            print(
                                "ppppppppppppppppppppppppppppppppppppppppppp");
                            print(e);
                            print(e.runtimeType);
                          }
                        }
                      } catch (e) {
                        print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                        print(e.runtimeType);
                        print(e);
                      }
                    },
                    child: const Text("Login"),
                  ),
                ],
              );

            default:
              return const Text("tggggg");
          }
        },
      ),
    );
  }
}
