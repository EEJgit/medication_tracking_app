import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 52, 69, 165),
        child: Column(
          children: [
            Lottie.network(
                "https://assets-v2.lottiefiles.com/a/458c5450-1179-11ee-bbde-bb08447ff885/An28bqOWU2.json"),
              
              const Text("ForgetFul? Not anymore.",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),),
              const Text(
              "Get Notified",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white
              ),
            ),
              
            
          ],
        ),
        /*Image.asset(
                    './assets/images/doc.png',
                    height: 40.0,
                  ));*/
      ),
    );
  }
}
