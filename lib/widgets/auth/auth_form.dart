import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(),
                    child: Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Create new account'),
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
