import 'package:chaljaabhai/views/login_screen.dart';
import 'package:chaljaabhai/views/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const RegisterScreen(title: 'Flutter Demo Home Page'),
      // home: const LoginScreen(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
              print(FirebaseAuth.instance.currentUser);
              final user = FirebaseAuth.instance.currentUser;
              if (user!.emailVerified) {
                print("verified");
              } else {
                print("Not verified bitchhhhhhhhhhhhh");
              }

              return Scaffold(
                body: Text("gg"),
              );
            default:
              return Text("ggg");
          }
        });
  }
}
