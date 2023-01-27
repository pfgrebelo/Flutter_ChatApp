import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //STARTS FIREBASE AUTH SDK
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  //FUNCTON TO SUBMIT AUTH FORM
  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
  ) async {
    UserCredential authResult;

    //TRY/CATCH FOR ERROR HANDLING
    try {
      setState(() {
        _isLoading = true;
      });
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

        //SAVES IMAGES ON user_images FOLDER IN THE FIREBASE STORAGE BUCKER WITH THE USER_ID AS FILE NAME
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user!.uid + '.jpg');
        await ref.putFile(image);

        final url = await ref.getDownloadURL();

        //ADD EXTRA USER DATA LIKE USERNAME IN A USERS COLLECTION
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'avatar_url' : url,
        });
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
      setState(() {
        _isLoading = false;
      });
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
