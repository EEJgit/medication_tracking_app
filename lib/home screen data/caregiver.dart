import 'package:flutter/material.dart';
import 'package:medication_tracking_app/components/medication_summary.dart';
import 'package:medication_tracking_app/components/medication_tile.dart';
import 'package:medication_tracking_app/data/medication_Data.dart';
import 'package:medication_tracking_app/models/model_item.dart';
import 'package:provider/provider.dart';

class CareGiver extends StatefulWidget {
  const CareGiver({super.key});

  @override
  State<CareGiver> createState() => _CareGiverState();
}

class _CareGiverState extends State<CareGiver> {
  //medication controllers declared here
  final medicationController = TextEditingController();
  final dosageController = TextEditingController();
  final patientController = TextEditingController();
  //The medications go down here
  void _addMedication() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add new Medication"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: medicationController,
                  ),
                  TextField(
                    controller: dosageController,
                  ),
                ],
              ),
              actions: [
                //the buttons
                MaterialButton(
                  onPressed: save,
                  child: const Text("Save"),
                ),

                MaterialButton(
                  onPressed: cancel,
                  child: const Text("Cancel"),
                ),
              ],
            ));
  }

  //save
  void save() {
    MedicationItem newMedication = MedicationItem(
        name: medicationController.text,
        datetime: DateTime.now(),
        dose: dosageController.text,
        patientsname: patientController.text);
    Provider.of<MedicationData>(context, listen: false)
        .addMedication(newMedication);
    //this pops out the dialog box when the user saves the medication
    Navigator.pop(context);
    clear();
  }

  //cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    //this method clears the input Textfields after the user puts in the data
    medicationController.clear();
    dosageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            "Care Giver",
            style: TextStyle(color: Colors.pink[300]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addMedication,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 30,),
            //weekly summary
            MedicationSummary(startOfWeek: value.startOfWeekDate()),

            //medication list
             ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getMedicationList().length,
              itemBuilder: (context, index) => MedicationTile(
                dosage: value.getMedicationList()[index].dose,
                name: value.getMedicationList()[index].name,
                dateTime: value.getMedicationList()[index].datetime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
