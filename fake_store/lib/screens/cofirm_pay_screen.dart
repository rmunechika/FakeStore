import 'package:fake_store/model/user_model.dart';
import 'package:flutter/material.dart';

import '../model/transaction_model.dart';
import 'home_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final User user;
  final Transaction transac;

  ConfirmationScreen({required this.transac, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Confirmation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Success!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text('Order ID: ${transac.id}'),
              Text('Name: ${transac.userName}'),
              Text('Email: ${transac.email}'),
              Text(
                  'Total Payment: \$${transac.totalPayment.toStringAsFixed(2)}'),
              Text(
                  'Date: ${transac.dateTime.toLocal().toString().split(' ')[0]}'),
              Text(
                  'Time: ${transac.dateTime.toLocal().toString().split(' ')[1]}'),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(user: user)),
                    (route) => false,
                  );
                },
                child: Text('Return to Homepage'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
