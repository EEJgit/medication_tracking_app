import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medication_tracking_app/models/medicine.dart';

class MedicationDetails extends StatefulWidget {
  const MedicationDetails(
    this.medicine, {
    super.key,
  });

  final Medicine medicine;

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
            backgroundColor: Colors.white,
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
                    fontSize: 18,
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
                    fontSize: 18,
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
        title: const Text(
          "Medication Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainSection(medicine: widget.medicine,),
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
        SizedBox(
          height: 30,
        ),
        ExtendedTabInfo(fieldTitle: "Medicine Type", fieldInfo: "Bottle"),
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
  const MainSection({super.key, this.medicine});
  //the medicine variables
  final Medicine? medicine;

  //The Hero Method
  Hero makeIcon(){
     if (medicine!.medicineType == 'Bottle') {
      return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/bottle.svg',
          height: 50,
        ),
      );
    }else if(medicine!.medicineType == 'Pill'){
       return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: SvgPicture.asset('assets/icons/pill.svg'),
      );
    }else if(medicine!.medicineType == 'Syringe'){
       return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: SvgPicture.asset('assets/icons/syringe.svg'),
      );
    }else if(medicine!.medicineType == 'Tablet') {
      return Hero(
        tag: medicine!.medicineName! + medicine!.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/tablet.svg',
          height: 30,
        ),
      );
    }
    return Hero(
      tag: medicine!.medicineName! + medicine!.medicineType!,
      child:const Icon(
        Icons.error,
        size: 40,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
          makeIcon()
        , Column(
          children: [
            //Medication Name details
            Hero(
              tag: medicine!.medicineName!,
              child: Material(
                color: Colors.transparent,
                child: MedicationInfoTab(
                fieldInfo: medicine!.medicineName!,
                fieldTitle: 'Medication Name',
                ),
              ),
            ),
            
            //This is the medication Dosage details
            MedicationInfoTab(
                fieldTitle: 'Dosage',
                fieldInfo: medicine!.dosage == 0
                    ? 'Not Specified'
                    : "${medicine!.dosage} mg"),
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
            style: TextStyle(
                fontSize: 25,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
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
