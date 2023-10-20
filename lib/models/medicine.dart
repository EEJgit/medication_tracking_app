// Import the necessary package for Flutter
import 'package:flutter/material.dart';

// Define a class named Medicine
class Medicine {
  // Properties to represent medication information

  // A list of dynamic data that stores notification IDs for this medicine.
  final List<dynamic>? notificationIDs;
  // A string that represents the name of the medicine.
  final String? medicineName;
  // An integer that represents the dosage of the medicine.
  final int? dosage;
  // A string that represents the type or category of the medicine.
  final String? medicineType;
  // An integer that represents the time interval between doses of the medicine.
  final int? interval;
  // A string that represents the time at which the medication should be taken.
  final String? startTime;

  // Constructor to create instances of the Medicine class
  Medicine({
    this.notificationIDs,
    this.medicineName,
    this.dosage,
    this.medicineType,
    this.startTime,
    this.interval,
  });

  /// This is the getter section of the medicine data

  // Getter to access the medicine name property
  String get getName => medicineName!;

  // Getter to access the dosage property
  int get getDosage => dosage!;

  // Getter to access the medicine type property
  String get getType => medicineType!;

  // Getter to access the interval property
  int get getInterval => interval!;

  // Getter to access the start time property
  String get getStartTime => startTime!;

  // Getter to access the notification IDs property
  List<dynamic> get getIDs => notificationIDs!;

  // Method to convert a Medicine instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'ids': notificationIDs,
      'name': medicineName,
      'dosage': dosage,
      'type': medicineType,
      'interval': interval,
      'start': startTime,
    };
  }

  // Factory method to create a Medicine instance from JSON data
  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(
      notificationIDs: parsedJson['ids'],
      medicineName: parsedJson['name'],
      dosage: parsedJson['dosage'],
      medicineType: parsedJson['type'],
      interval: parsedJson['interval'],
      startTime: parsedJson['start'],
    );
  }
}
