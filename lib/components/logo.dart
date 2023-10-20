import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return //Logo for the app
                Row(
                  children: [
                    const Text(
                      "Med",
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sense",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.medication,
                      color: Colors.red[900],
                    )
                  ],
                );
  }
}