class MedicationItem {
  final String name;
  final String dose;
  final String patientsname;
  final DateTime datetime;

  MedicationItem({
    required this.name,
    required this.datetime,
    required this.dose,
    required this.patientsname,
  });
}
