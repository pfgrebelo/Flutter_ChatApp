import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //STARTS FIREBASE AUTH SDK
  final _auth = FirebaseAuth.instance;

  //FUNCTON TO SUBMIT AUTH FORM
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
  ) async {
    UserCredential authResult;

    //TRY/CATCH FOR ERROR HANDLING
    try {
      //IF ITS LOGIN TRIES TO SIGN IN THE USER
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Logged In!',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
        //TRIES TO CREATE A NEW USER ACCOUNT
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Success! You just created a new account!',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        );
      }
      //on FirebaseAuthException TO CATCH SPECIFIC ERRORS THROWN BY FIREBASE
    } on FirebaseAuthException catch (error) {
      //GENERAL ERROR MESSAGE
      var message = 'An error occurred, please check your credentials!';
      //REPLACES THE GENERAL ERROR MESSAGE WITH FIREBASE ERROR MESSAGE
      if (error.message != null) {
        message = error.message!;
      }
      //SHOWS ERROR TO THE USER
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      //CATCH REMAINING ERRORS
    } catch (error) {
      print(error);
      var message = 'An error occurred, please try again!';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AuthForm(_submitAuthForm),
    );
  }
}
