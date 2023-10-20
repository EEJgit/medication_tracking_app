import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MedicationDetails extends StatefulWidget {
  const MedicationDetails({super.key});

  @override
  State<MedicationDetails> createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
  openAlertBox(BuildContext context) {
    // this is alert box for the deletion confirmation
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            title: const Text(
              "Delete this Reminder?",
              style: TextStyle(
                color: Color.fromARGB(255, 52, 69, 165),
              ),
            ),
            //the actions for the cancel and confirm deletion  button
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color.fromARGB(255, 52, 69, 165),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //this is the global bloc to delete the  medication.

                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                    color: Colors.red[400],
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const MainSection(),
            //The extended tab for more information for the medication.
            const ExtendedSection(),
            const Spacer(),
            //the delete button
            SizedBox(
              width: 400,
              height: 56,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.red;
                      }
                      return const Color.fromARGB(255, 226, 74, 74);
                    },
                  ),
                ),
                onPressed: () {
                  //open the alert dialog for the deletion notice. plus the global bloc to delete and manage the medication states.
                  openAlertBox(context);
                },
                child: const Text(
                  "D E L E T E",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

//Extended tab, which lays the medication info in a ListView
class ExtendedSection extends StatelessWidget {
  const ExtendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        ExtendedTabInfo(fieldTitle: "Medicine Type", fieldInfo: "Pillz"),
        ExtendedTabInfo(
            fieldTitle: "Dose Interval",
            fieldInfo: "Every 6 hours | 3 times a day"),
        ExtendedTabInfo(fieldTitle: "Start Time", fieldInfo: "12:30")
      ],
    );
  }
}

//MainTab information for the medication
class MainSection extends StatelessWidget {
  const MainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          "assets/icons/bottle.svg",
          height: 80,
        ),
        const Column(
          children: [
            //Medication Name details
            MedicationInfoTab(
              fieldInfo: "Benlyne",
              fieldTitle: 'Medication Name',
            ),
            //This is the medication Dosage details
            MedicationInfoTab(fieldInfo: "200g", fieldTitle: "Dosage")
          ],
        ),
      ],
    );
  }
}

class MedicationInfoTab extends StatelessWidget {
  const MedicationInfoTab(
      {super.key, required this.fieldInfo, required this.fieldTitle});
  final String fieldTitle;
  final String fieldInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 80,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7,
            ),
            Text(
              fieldTitle, //the name of the medication down here should be dynamic
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              fieldInfo,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExtendedTabInfo extends StatelessWidget {
  const ExtendedTabInfo(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldTitle,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            fieldInfo,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 52, 69, 165)),
          ),
        ],
      ),
    );
  }
}
