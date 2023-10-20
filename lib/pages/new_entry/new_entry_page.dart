// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medication_tracking_app/common/convert_time.dart';
import 'package:medication_tracking_app/global_bloc.dart';
import 'package:medication_tracking_app/models/errors.dart';
import 'package:medication_tracking_app/models/medication_type.dart';
import 'package:medication_tracking_app/models/medicine.dart';
import 'package:medication_tracking_app/pages/new_entry/errors_entry.dart';
import 'package:medication_tracking_app/pages/new_entry/new_entry_bloc.dart';
import 'package:medication_tracking_app/success_screen/success_scren.dart';
import 'package:provider/provider.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({
    super.key,
  });

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  late TextEditingController medicationController;
  late TextEditingController dosageController;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late NewEntryBloc _newEntryBloc;

  @override
  void dispose() {
    super.dispose();
    medicationController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    medicationController = TextEditingController();
    dosageController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _newEntryBloc = NewEntryBloc();
    initializeErrorListen();
  }

  //this method is used to make the ids
  List<int> makeIds(double n) {
    var rng = Random();
    List<int> ids = [];
    for (var i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }

  //the initialize error method TODO: this method below.
  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((ErrorEntry error) {
      switch (error) {
        case ErrorEntry.nameNull:
          displayError("Enter the medicine's name");
          break;
        case ErrorEntry.nameDuplicate:
          displayError("This Medication Already Exists");
          break;
        case ErrorEntry.dosage:
          displayError("Please Enter the required med");
          break;
        case ErrorEntry.type:
          // TODO: Handle this case.
          break;
        case ErrorEntry.interval:
          displayError("Please enter the required Interval");
          break;
        case ErrorEntry.startTime:
          displayError("Please enter the medication's time");
        case ErrorEntry.none:
          // TODO: Handle this case.
          break;
      }
    });
  }

  //TODO: this displays the error to the screen
  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Center(child: Text(error)),
      duration: Duration(
        milliseconds: 2000,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Add New",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const PanelTile(
              title: 'Medication Name',
              isRequired: true,
            ),
            TextFormField(
              maxLength: 12,
              controller: medicationController,
              style: const TextStyle(
                color: Color.fromARGB(255, 52, 69, 165),
              ),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            const PanelTile(
              isRequired: false,
              title: 'Dosage in Mg',
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 12,
              controller: dosageController,
              style: const TextStyle(
                color: Color.fromARGB(255, 52, 69, 165),
              ),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            const PanelTile(isRequired: false, title: "Medication Type"),
            const SizedBox(height: 7),
            StreamBuilder(
                //stream: _newEntryBloc,
                stream: context.watch<NewEntryBloc>().selectedMedicineType,
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MedicationTypeColumn(
                        iconValue: 'assets/icons/bottle.svg',
                        isSelected:
                            snapshot.data == MedicineType.bottle ? true : false,
                        medicineType: MedicineType.bottle,
                        name: "bottle",
                      ),
                      MedicationTypeColumn(
                        iconValue: 'assets/icons/syringe.svg',
                        isSelected: snapshot.data == MedicineType.syringe
                            ? true
                            : false,
                        medicineType: MedicineType.syringe,
                        name: "syringe",
                      ),
                      MedicationTypeColumn(
                        iconValue: 'assets/icons/pill.svg',
                        isSelected:
                            snapshot.data == MedicineType.pill ? true : false,
                        medicineType: MedicineType.pill,
                        name: "pill",
                      ),
                    ],
                  );
                }),
            const SizedBox(height: 8),
            const PanelTile(isRequired: true, title: "Sections Interval"),
            const SizedBox(height: 8),
            const Row(
              children: [
                IntervalSelection(),
              ],
            ),
            const PanelTile(isRequired: true, title: "Sorting Time"),
            const SelectTime(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 9),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 180,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 52, 69, 165),
                    ),
                    onPressed: () {
                      //add medication

                      //medication validation

                      // Handle the functionality of the confirm button here.
                      String? medicationName;
                      int? dosage;
                      if (medicationController.text == "") {
                        _newEntryBloc.submitError(ErrorEntry.nameNull);
                        return;
                      }
                      if (medicationController.text != "") {
                        medicationName = medicationController.text;
                      }
                      if (dosageController.text == "") {
                        dosage = int.parse(dosageController.text);
                      }
                      if (dosageController.text != "") {
                        dosage = int.parse(dosageController.text);
                      }
                      for (var medicine in globalBloc.medicineList$!.value) {
                        if (medicationName == medicine.medicineName) {
                          _newEntryBloc.submitError(ErrorEntry.nameDuplicate);
                          return;
                        }
                      }
                      if (_newEntryBloc.selectIntervals!.value == 0) {
                        _newEntryBloc.submitError(ErrorEntry.interval);
                        return;
                      }
                      if (_newEntryBloc.selectedTimeOfDay$!.value == "none") {
                        _newEntryBloc.submitError(ErrorEntry.startTime);
                        return;
                      }

                      String medicineType = _newEntryBloc
                          .selectedMedicineType!.value
                          .toString()
                          .substring(13);

                      int interval = _newEntryBloc.selectIntervals!.value;

                      String startOfTime =
                          _newEntryBloc.selectedTimeOfDay$!.value;
                      List<int> intIds =
                          makeIds(24 / _newEntryBloc.selectIntervals!.value);
                      List<String> notificationIDs =
                          intIds.map((i) => i.toString()).toList();

                      Medicine newEntryMedicine = Medicine(
                        notificationIDs: notificationIDs,
                        medicineName: medicationName,
                        medicineType: medicineType,
                        dosage: dosage,
                        interval: interval,
                        startTime: startOfTime,
                      );
                      //update the medication list using the global bloc
                      globalBloc.updateMedicationList(newEntryMedicine);
                      //schedule notification

                      //lead to success screen routes.
                      /*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuccessScreen(),),);

                      */
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay timeOfDay = const TimeOfDay(hour: 0, minute: 0);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (picked != null && picked != timeOfDay) {
      setState(() {
        timeOfDay = picked;
        _clicked = true;
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blueAccent.withOpacity(0.5);
                }
                return Color.fromARGB(255, 52, 69, 165);
              },
            ),
          ),
          onPressed: () {
            _selectTime(context);
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Select time"
                  : "${convertTime(timeOfDay.hour.toString())}:${convertTime(timeOfDay.minute.toString())}",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class PanelTile extends StatelessWidget {
  const PanelTile(
      {super.key, Key? keys, required this.isRequired, required this.title});
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class MedicationTypeColumn extends StatelessWidget {
  const MedicationTypeColumn({
    super.key,
    Key? keys,
    required this.iconValue,
    required this.isSelected,
    required this.medicineType,
    required this.name,
  });
  final String name;
  final String iconValue;
  final bool isSelected;
  final MedicineType medicineType;

  @override
  Widget build(BuildContext context) {
    final newEntry = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        newEntry.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isSelected
                  ? Colors.blue[200]
                  : Color.fromARGB(255, 52, 69, 165),
            ), //The Icons
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                iconValue,
                height: 40,
                width: 20,
                // ignore: deprecated_member_use
                //color: Colors.blue
              ),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Container(
            width: 70,
            height: 30,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blue[200]
                  : Color.fromARGB(255, 52, 69, 165),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: isSelected ? Colors.grey[200] : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({
    super.key,
  });

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Remind me Every",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          width: 18,
        ),
        DropdownButton(
          iconEnabledColor: Color.fromARGB(255, 52, 69, 165),
          dropdownColor: Colors.grey[200],
          hint: _selected == 0
              ? Text(
                  "Select an interval",
                  style: TextStyle(
                    color: Color.fromARGB(255, 52, 69, 165),
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
          value: _selected == 0 ? null : _selected,
          items: _intervals.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                value.toString(),
                style: const TextStyle(color: Color.fromARGB(255, 52, 69, 165)),
              ),
            );
          }).toList(),
          onChanged: (newval) {
            setState(() {
              _selected = newval!;
              _newEntryBloc.updateInterval(newval);
            });
          },
        ),
        const SizedBox(
          width: 18,
        ),
        Text(
          _selected == 1 ? "hour" : "hours",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
