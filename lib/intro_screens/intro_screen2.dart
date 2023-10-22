import 'package:flutter/material.dart';

class IntroScreenTwo extends StatelessWidget {
  const IntroScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: const Color.fromARGB(255, 52, 69, 165),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Keep Your medication in check",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/pill2.png',
                height: 200,
              ),
              const Text(
                  "Medsense notifies you when \n its time to take medicine.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ],
          ),
        ),
      ),
      /* Image.asset(
        './assets/images/pills.png',
        height: 40.0,
      ),*/
    );
  }
}
