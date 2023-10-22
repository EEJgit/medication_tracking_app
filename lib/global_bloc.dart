import 'dart:convert';

import 'package:medication_tracking_app/models/medicine.dart';
import 'package:rxdart/subjects.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc {
  BehaviorSubject<List<Medicine>>? _medicationList$;
  BehaviorSubject<List<Medicine>>? get medicineList$ => _medicationList$;

  //global bloc constructor
  GlobalBloc() {
    _medicationList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    makeMedicationList();
  }

    Future updateMedicineList(Medicine newMedicine) async {
    var blocList = medicineList$!.value;
    blocList.add(newMedicine);
    medicineList$!.add(blocList);

    Map<String, dynamic> tempMap = newMedicine.toJson();
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if (sharedUser.getStringList('medicines') == null) {
      medicineJsonList.add(newMedicineJson);
    } else {
      medicineJsonList = sharedUser.getStringList('medicines')!;
      medicineJsonList.add(newMedicineJson);
    }
    sharedUser.setStringList('medicines', medicineJsonList);
  }

  Future makeMedicationList() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('medicines');
    List<Medicine> prefList = [];

    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        dynamic userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      //state update
      _medicationList$!.add(prefList);
    }
  }

  void dispose() {
    _medicationList$!.close();
  }
}
