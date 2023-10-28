import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MedicationInteractionScreen extends StatefulWidget {
  const MedicationInteractionScreen({super.key});

  @override
  State<MedicationInteractionScreen> createState() =>
      _MedicationInteractionScreenState();
}

class _MedicationInteractionScreenState
    extends State<MedicationInteractionScreen> {
  List _items = [];

  //fetch the content from the json file
  Future<void> readJson() async {
    //with this line we are able to load the json file as a string and save it in the response variable
    final String response =
        await rootBundle.loadString('assets/interaction.json');
    //next we decode the string from the response variable and load the value in the varible called data.
    final data = await json.decode(response);

    //here we let our UI know that we have loaded the data and the variable _item has been update.
    setState(() {
      _items = data['interactionType'];
      print("The length of this file is ${_items.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ElevatedButton(
          onPressed: () {
            readJson();
          },
          child: const Text("Fetch Data"),
        ),
      ),
    );
  }
}
