//With this we convert a daYtime object to a string = yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  //this is for the year to be converted to a string in the format yyyy
  String year = dateTime.year.toString();
  //convert the month to string in the format mm
  String month = dateTime.month.toString();
  //if the month has a single digit, we will append a zero in front of it
  if (month.length == 1) {
    month = "0$month";
  }
  //convert the day to string in the format dd
  String day = dateTime.day.toString();
  //if the day has a single digit we append a zero infront of it
  if (day.length == 1) {
    day = "0$day";
  }
  //we put together the year/month/day to convert them to the string below.
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
