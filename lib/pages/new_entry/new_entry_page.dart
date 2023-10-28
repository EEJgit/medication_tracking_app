// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medication_tracking_app/constants.dart';
import 'package:medication_tracking_app/global_bloc.dart';
import 'package:medication_tracking_app/local%20notifications/local_notifications.dart';
import 'package:medication_tracking_app/models/errors.dart';
import 'package:medication_tracking_app/models/medication_type.dart';
import 'package:medication_tracking_app/models/medicine.dart';
import 'package:medication_tracking_app/pages/new_entry/another_page.dart';
import 'package:medication_tracking_app/pages/new_entry/new_entry_bloc.dart';
import 'package:medication_tracking_app/success_screen/success_scren.dart';

import 'package:provider/provider.dart';
import '../../common/convert_time.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({Key? key}) : super(key: key);

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  late TextEditingController nameController;
  late TextEditingController dosageController;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _newEntryBloc = NewEntryBloc();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeErrorListen();
    listenToNotifications();
  }

  //TODO: the state for the notification
  //to listen to any notification clicked or not
  listenToNotifications() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AnotherPage(payload: event)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add New',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        body: Provider<NewEntryBloc>.value(
          value: _newEntryBloc,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2,
                ),
                //NextOfKin()
                const PanelTitle(
                  title: 'Medicine Name',
                  isRequired: true,
                ),
                TextFormField(
                  maxLength: 12,
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(255, 52, 69, 165),
                      fontWeight: FontWeight.w400),
                ),
                const PanelTitle(
                  title: 'Dosage in mg',
                  isRequired: false,
                ),
                TextFormField(
                  maxLength: 12,
                  controller: dosageController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(255, 52, 69, 165),
                      fontWeight: FontWeight.w400),
                ),
                const PanelTitle(title: 'Medicine Type', isRequired: false),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: StreamBuilder<MedicineType>(
                    //new entry block
                    stream: _newEntryBloc.selectedMedicineType,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //not yet clickable?
                          MedicineTypeColumn(
                              medicineType: MedicineType.Bottle,
                              name: 'Bottle',
                              iconValue: 'assets/icons/bottle.svg',
                              isSelected: snapshot.data == MedicineType.Bottle
                                  ? true
                                  : false),
                          MedicineTypeColumn(
                              medicineType: MedicineType.Pill,
                              name: 'Pill',
                              iconValue: 'assets/icons/pill.svg',
                              isSelected: snapshot.data == MedicineType.Pill
                                  ? true
                                  : false),
                          MedicineTypeColumn(
                              medicineType: MedicineType.Syringe,
                              name: 'Syringe',
                              iconValue: 'assets/icons/syringe.svg',
                              isSelected: snapshot.data == MedicineType.Syringe
                                  ? true
                                  : false),
                          MedicineTypeColumn(
                              medicineType: MedicineType.Tablet,
                              name: 'Tablet',
                              iconValue: 'assets/icons/tablet.svg',
                              isSelected: snapshot.data == MedicineType.Tablet
                                  ? true
                                  : false),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                const PanelTitle(title: 'Interval Selection', isRequired: true),
                const IntervalSelection(),
                const PanelTitle(title: 'Starting Time', isRequired: true),
                const SelectTime(),
                //NextOfKin(),//just added
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: SizedBox(
                    width: 400,
                    height: 45,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 52, 69, 165),
                      ),
                      child: const Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      onPressed: () {
                        //add medicine
                        //some validations
                        //go to success screen
                        String? medicineName;
                        int? dosage;

                        //medicineName
                        if (nameController.text == "") {
                          _newEntryBloc.submitError(ErrorEntry.nameNull);
                          return;
                        }
                        if (nameController.text != "") {
                          medicineName = nameController.text;
                        }
                        //dosage
                        if (dosageController.text == "") {
                          dosage = 0;
                        }
                        if (dosageController.text != "") {
                          dosage = int.parse(dosageController.text);
                        } //medication Namae
                        for (var medicine in globalBloc.medicineList$!.value) {
                          if (medicineName == medicine.medicineName) {
                            _newEntryBloc.submitError(ErrorEntry.nameDuplicate);
                            return;
                          }
                        } //mediaction Intervals
                        if (_newEntryBloc.selectIntervals!.value == 0) {
                          _newEntryBloc.submitError(ErrorEntry.interval);
                          return;
                        }
                        if (_newEntryBloc.selectedTimeOfDay$!.value == 'None') {
                          _newEntryBloc.submitError(ErrorEntry.startTime);
                          return;
                        }

                        String medicineType = _newEntryBloc
                            .selectedMedicineType!.value
                            .toString()
                            .substring(13);

                        int interval = _newEntryBloc.selectIntervals!.value;
                        String startTime =
                            _newEntryBloc.selectedTimeOfDay$!.value;

                        List<int> intIDs =
                            makeIDs(24 / _newEntryBloc.selectIntervals!.value);
                        Medicine newEntryMedicine = Medicine(
                            medicineName: medicineName,
                            dosage: dosage,
                            medicineType: medicineType,
                            interval: interval,
                            startTime: startTime);

                        //update medicine list via global bloc
                        globalBloc.updateMedicineList(newEntryMedicine);

                        //schedule notification
                        LocalNotifications.showSimpleNotification(
                            title: "Medication Tracking",
                            body:
                                "$medicineName Saved! To be Taken at $startTime Check interactions",
                            payload:
                                "$medicineName is not interacting with any medication at $startTime");

                        //Periodic notification
                        LocalNotifications.showPeriodicNotifications(
                          title: "Periodic Medicine tracking",
                          body: "Time to take $medicineName dosage",
                          payload: "periodic Data",
                        );

                        //Listening for notifications

                        listenToNotifications();
                        //Move to the next success screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccessScreen()));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //##############################################
  //##############################################
  //time to schedule notifications

//the method to initialize the error incase error handling
  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((ErrorEntry error) {
      switch (error) {
        case ErrorEntry.nameNull:
          displayError("Please enter the medicine's name");
          break;

        case ErrorEntry.nameDuplicate:
          displayError("Medicine name already exists");
          break;
        case ErrorEntry.dosage:
          displayError("Please enter the dosage required");
          break;
        case ErrorEntry.interval:
          displayError("Please select the reminder's interval");
          break;
        case ErrorEntry.startTime:
          displayError("Please select the reminder's starting time");
          break;
        default:
      }
    });
  }

//display error method
  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[400],
        content: Center(
          child: Text(error,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        ),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
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
    //Time bug fix
    NewEntryBloc newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);
    //The bug fix ends here
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (picked != null && picked != timeOfDay) {
      setState(() {
        timeOfDay = picked;
        _clicked = true;
        //The time state provider
        newEntryBloc.updateTime(convertTime(timeOfDay.hour.toString()) +
            convertTime(timeOfDay.minute.toString()));
        int hour;
        int minutes;
        hour = int.parse(convertTime(timeOfDay.hour.toString()));
        minutes = int.parse(convertTime(timeOfDay.minute.toString()));
        FlutterAlarmClock.createAlarm(hour: hour, minutes: minutes);
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blueAccent.withOpacity(0.5);
                }
                return const Color.fromARGB(255, 52, 69, 165);
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

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({Key? key}) : super(key: key);

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Remind every',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          DropdownButton(
            iconEnabledColor: Color.fromARGB(255, 52, 69, 165),
            dropdownColor: kScaffoldColor,
            hint: _selected == 0
                ? Text('Select Interval',
                    style: TextStyle(
                        color: Color.fromARGB(255, 52, 69, 165),
                        fontWeight: FontWeight.w700))
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 52, 69, 165),
                          fontWeight: FontWeight.w300)),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(
                () {
                  _selected = newVal!;
                  newEntryBloc.updateInterval(newVal);
                },
              );
            },
          ),
          Text(
            _selected == 1 ? " hour" : " hours",
            style: TextStyle(
              color: Color.fromARGB(255, 52, 69, 165),
                fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn(
      {Key? key,
      required this.medicineType,
      required this.name,
      required this.iconValue,
      required this.isSelected})
      : super(key: key);
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        //select medicine type
        //lets create a new block for selecting and adding new entry
        newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isSelected
                    ? Color.fromARGB(255, 52, 69, 165)
                    : Colors.white),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 18,
                  bottom: 18,
                ),
                child: SvgPicture.asset(
                  iconValue,
                  height: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Container(
              width: 75,
              height: 21,
              decoration: BoxDecoration(
                color: isSelected
                    ? Color.fromARGB(255, 52, 69, 165)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.grey[200]
                        : Color.fromARGB(255, 52, 69, 165),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({Key? key, required this.title, required this.isRequired})
      : super(key: key);
  final String title;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 52, 69, 165),
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: isRequired ? " *" : "",
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Center(
        child: Column(
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
                  color: Colors.white, borderRadius: BorderRadius.circular(11)),
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
      ],
    ));
    //Controllers end here
  }
}

// hourController = timeOfDay.hour.toString()

