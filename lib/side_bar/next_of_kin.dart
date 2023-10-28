// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

class NextOfKin extends StatefulWidget {
  const NextOfKin({super.key});

  @override
  State<NextOfKin> createState() => _NextOfKinState();
}

class _NextOfKinState extends State<NextOfKin> {
  final hourController = TextEditingController();
  final minuteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              //Input Hour
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11)),
                    child: Center(
                      child: TextField(
                        controller: hourController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  //Input minute
                  Text(
                    ":",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11)),
                    child: Center(
                      child: TextField(
                        controller: minuteController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              //Controllers end here

              Container(
                color: Colors.red,
                margin: const EdgeInsets.all(25),
                child: TextButton(
                  child: const Text(
                    'Create alarm',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    int hour;
                    int minutes;
                    hour = int.parse(hourController.text);
                    minutes = int.parse(minuteController.text);

                    // creating alarm after converting hour
                    // and minute into integer
                    FlutterAlarmClock.createAlarm(hour: hour, minutes: minutes);
                  },
                ),
              ),
              /*
              ElevatedButton(
                onPressed: () {
                  // show alarm
                  FlutterAlarmClock.showAlarms();
                },
                child: const Text(
                  'Show Alarms',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                child: TextButton(
                    child: const Text(
                      'Create timer',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      int minutes;
                      minutes = int.parse(minuteController.text);

                      // create timer
                      FlutterAlarmClock.createTimer(length: minutes);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AboutDialog(
                              children: [
                                Center(
                                  child: Text("Timer is set",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            );
                          });
                    }),
              ),
              ElevatedButton(
                onPressed: () {
                  // show timers
                  FlutterAlarmClock.showTimers();
                },
                child: Text(
                  "Show Timers",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}

/*Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "The Next of Kin Page",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            "The Next of Kin.",
            style: TextStyle(
              color:Colors.grey[700]
            ),
          ),
        ],
      ),
    );


    ///This is the first Row
    /// Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(11)),
                child: Center(
                  child: TextField(
                    controller: hourController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(11)),
                child: Center(
                  child: TextField(
                    controller: minuteController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
    */
