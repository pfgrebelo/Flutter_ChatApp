import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/X76YqtPJPY8PqKtcq15p/messages')
              .snapshots()
              .listen((data) {
            data.docs.forEach((document) { 
              print(document['text']);
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
