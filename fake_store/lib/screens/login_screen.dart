import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  void _sendLoginData(BuildContext context) {
    final user = User(
      name: _nameController.text,
      email: _emailController.text,
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
            image: AssetImage('assets/Home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white54,
              ),
              child: const Text(
                'Login :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: TextField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black45,
                  label: Text('Username'),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_emailFocusNode);
                },
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 250,
              child: TextField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black45,
                  label: Text('Email'),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: () {
                  _sendLoginData(context);
                },
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _sendLoginData(context);
              },
              child:
                  Text('Masuk', style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
