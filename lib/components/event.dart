import 'package:flutter/material.dart';
import 'package:lettutor20120205/models/schedule/booking_info.dart';

class Event {
  final String date;
  final int startHour;
  final String startMinute;
  final int endHour;
  final String endMinute;
  final BookingInfo courseInfo;
  Event(
    this.date,
    this.startHour,
    this.startMinute,
    this.endHour,
    this.endMinute,
    this.courseInfo,
  );
}
