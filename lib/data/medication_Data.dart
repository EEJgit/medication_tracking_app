// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:medication_tracking_app/date%20time/date_time_helper.dart';
import 'package:medication_tracking_app/models/model_item.dart';

class MedicationData extends ChangeNotifier {
  //List of all medication
  List<MedicationItem> overallMedicationList = [];
  //get medication list
  List<MedicationItem> getMedicationList() {
    return overallMedicationList;
  }

  //add medication
  void addMedication(MedicationItem medication) {
    overallMedicationList.add(medication);
    notifyListeners();
    
  }

  //delete medication
  void deleteMedication(MedicationItem medication) {
    overallMedicationList.remove(medication);
    notifyListeners();
  }

  ///show th days of the week(Sunday - Monday).from a data and time object
  ///get the date for the start of the week.
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  //Get the day of the week
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get today's date
    DateTime today = DateTime.now();

    //go back in the week to find the nearest sunday
    for (int i = 0; i < 7; i++) {
      //check through the days to find the next sunday
      if (getDayName(today.subtract(Duration(days: i))) == "Sun") {
        //startOfWeek == today.subtract(Duration(days: i));
        startOfWeek = today.subtract(Duration(days: i));

      }
    }
    //returns sunday as the start of the week
    return startOfWeek!;
  }

  ///each medication in here is going to have a
  ///name 2010/30/12 and the amount
  ///
  ///we also create a summary for each day and the dosage taken
  Map<String, double> calculateMedicationSummary() {
    Map<String, double> dailyMedicationSummary = {
      //date (yyyymmdd) : amountTotalForDay.
    };
    for (var medication in overallMedicationList) {
      //initialize the date to tehe date time method fromt the dateTime file
      String date = convertDateTimeToString(medication.datetime);
      //this is the dose
      double dose = double.parse(medication.dose);

      if (dailyMedicationSummary.containsKey(date)) {
        //the current day's dosage
        double currentDose = dailyMedicationSummary[date]!;
        currentDose += dose;
        //the daily medication
        dailyMedicationSummary[date] = currentDose;
      } else {
        //we add the date and dose amounts
        dailyMedicationSummary.addAll({date: dose});
      }
    }
    return dailyMedicationSummary;
  }
}
