import 'package:flutter/material.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 52, 69, 165),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            SizedBox(height: 50),
            Text("ForgetFul? Not anymore.",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),),
            Text(
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
    );
  }
}
