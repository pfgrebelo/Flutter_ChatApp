import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); //closes keyboard on submit

    if (isValid) {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
      //Use those values to send our auth request ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if(!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        return 'Please enter at least 3 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onSaved: (newValue) {
                      _userName = newValue!;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    obscureText: true,
                    onSaved: (newValue) {
                      _userPassword = newValue!;
                    },
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin ? 'Create new account' : 'I already have an account'),
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
