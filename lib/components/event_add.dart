import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/chapter_card.dart';
import 'package:lettutor20120205/components/course_card.dart';
import 'package:lettutor20120205/detail-courses-widgets/chapter_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.hours);
  String eventName;
  int hours;
  DateTime from;
  DateTime to;
}

class ListMeeting {
  final List<Meeting> listmeet = [];
}
