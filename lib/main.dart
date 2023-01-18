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
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal,
              backgroundColor: Colors.teal,
              brightness: Brightness.light,
            ).copyWith(
              secondary: Colors.deepPurple,
            ),
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.3,
                ),
              ),
            ),
          ),
          home: appSnapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : AuthScreen(),
        );
      },
    );
  }
}
