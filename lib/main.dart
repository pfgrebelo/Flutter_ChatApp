import 'package:flutter/material.dart';
import './screens/auth_screen.dart';
import './screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, appSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FlutterChat',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: appSnapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) : AuthScreen(),
        );
      },
    );
  }
}
