// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:medication_tracking_app/pages/home_page.dart';

class AnotherPage extends StatelessWidget {
  final String payload;
  const AnotherPage({super.key,  required this.payload});

  @override
  Widget build(BuildContext context) {
    //reroute to the home page
    void home() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: home,
            icon: Icon(
              Icons.home,
              color: Colors.pink,
              size: 30,
            ),
          ),
        ],
        title: Text(
          "Medication interactions",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              " $payload",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green), // You can style this as needed.
            ),
            /*
            Table(
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                    decoration: BoxDecoration(color: Colors.white),
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Text("Time",style: TextStyle(color: Colors.black),),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Text("Name"),
                        ),
                      ),
                       TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                          child: Text("Dose"),
                        ),
                      ),
                    ])
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
