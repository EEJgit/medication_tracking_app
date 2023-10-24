import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medication_tracking_app/pages/home_page.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.white,
      child: Center(
        child: Text("Success",
        style:TextStyle(
          color: Colors.green[700],
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )
        )
        /*
          child: FlareActor(
        'assets/animations/Success Check.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: 'Untitled',
      ),*/
      ),
    );
  }
}
