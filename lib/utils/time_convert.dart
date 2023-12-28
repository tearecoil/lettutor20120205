import 'package:intl/intl.dart';

String convertTimeStampToHour(int timestamp) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final String hour = DateFormat('HH:mm').format(date);
  return hour;
  //return "18:30";
}

String convertTimeStampToDay(int timestamp) {
  final String day = DateFormat.yMMMEd()
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  return day;
  //return Fri, Dec 29, 2023
}

DateTime convertTimeStampToDate(int timestamp) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return date;
}
