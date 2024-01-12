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

String getRemainingTimer(Duration currentTime) {
  final String days = currentTime.inDays.toString().padLeft(2, '0');
  final String hours =
      currentTime.inHours.remainder(24).toString().padLeft(2, '0');
  final String minutes =
      currentTime.inMinutes.remainder(60).toString().padLeft(2, '0');
  final String seconds =
      currentTime.inSeconds.remainder(60).toString().padLeft(2, '0');

  return '$days:$hours:$minutes:$seconds';
}
