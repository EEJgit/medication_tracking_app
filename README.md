# medication_tracking_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


//Storing of the reusable code snipets
appBar: AppBar(
            title: const Logo(),
            actions: [
              IconButton(
                onPressed: signOut,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.pink,
                  size: 30,
                ),
              ),
            ],
          ),

//this is the code for the timer to call a function and the time must be user defined
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerApp(),
    );
  }
}

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  final TextEditingController _durationController = TextEditingController();
  int _timerDuration = 0;
  String _displayMessage = '';
  Timer? _timer;

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

  void startTimer() {
    int enteredDuration = int.tryParse(_durationController.text) ?? 0;

    if (enteredDuration > 0) {
      setState(() {
        _timerDuration = enteredDuration;
      });

      if (_timer != null) {
        _timer!.cancel();
      }

      _timer = Timer(Duration(seconds: _timerDuration), displayMessage);
    }
  }

  void displayMessage() {
    setState(() {
      _displayMessage = "Timer expired after $_timerDuration seconds!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Timer Duration (seconds)'),
            ),
            ElevatedButton(
              onPressed: startTimer,
              child: Text('Start Timer'),
            ),
            SizedBox(height: 16),
            Text(_displayMessage, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

//ends here

