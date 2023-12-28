// import 'dart:html';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/event.dart';
import 'package:lettutor20120205/homescreens-widgets/homescreens-widgets-dialog/cancel_dialog.dart';
import 'package:lettutor20120205/models/schedule/booking_info.dart';
import 'package:lettutor20120205/service-api/booking-services.dart';
import 'package:lettutor20120205/utils/time_convert.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

// List<Meeting> meeting = <Meeting>[];
// List<bool> state = [] ?? [false];
// int? totalhours;

class _SchedulePageState extends State<SchedulePage> {
  int totalhours = 0;
  int totalminutes = 0;
  late String chosen;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  Map<String, List<Event>> events = {};
  late final ValueNotifier<List<Event>> _selectedEvents;
  List<BookingInfo>? _bookings;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    String pushDate = "";
    pushDate = pushDate + _selectedDay!.year.toString();
    if (_selectedDay!.month.toString().length < 2)
      pushDate = pushDate + "0${_selectedDay!.month}";
    else
      pushDate = pushDate + "${_selectedDay!.month}";
    if (_selectedDay!.day.toString().length < 2)
      pushDate = pushDate + "0${_selectedDay!.day}";
    else
      pushDate = pushDate + "${_selectedDay!.day}";
    _selectedEvents = ValueNotifier(_getEventsForDay(DateTime.parse(pushDate)));
    // setCourseNamefromList();
    totalhours = 0;
    totalminutes = 0;
    events = {};
    _getBookingListByStudent();
  }

  void _getBookingListByStudent() async {
    await BookingService.getBookingListByStudent(
        page: 1,
        perPage: 10,
        onSuccess: (bookings) {
          setState(() {
            _bookings = bookings;
            // print(_bookings);
            getCourseInfo(_bookings!);
          });
        },
        onError: (message) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void setCourseNamefromList() {
  //   for (var course in CourseList().Course_List) {
  //     CourseName.add(course.title);
  //   }
  //   // print(CourseName);
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // print(selectedDay);
    // print(events);
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // print(_selectedDay);
        // String pushDate =
        //     "${_selectedDay!.year}-${_selectedDay!.month}-${_selectedDay!.day}";
        String pushDate = "";
        pushDate = pushDate + _selectedDay!.year.toString();
        if (_selectedDay!.month.toString().length < 2)
          pushDate = pushDate + "0${_selectedDay!.month}";
        else
          pushDate = pushDate + "${_selectedDay!.month}";
        if (_selectedDay!.day.toString().length < 2)
          pushDate = pushDate + "0${_selectedDay!.day}";
        else
          pushDate = pushDate + "${_selectedDay!.day}";
        _selectedEvents.value = _getEventsForDay(DateTime.parse(pushDate));
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    // print(events);
    // print(day);
    // print(events[day]);
    String getEvent = "";
    getEvent = getEvent + day.year.toString();
    if (day.month.toString().length < 2)
      getEvent = getEvent + "0${day.month}";
    else
      getEvent = getEvent + "${day.month}";
    if (day.day.toString().length < 2)
      getEvent = getEvent + "0${day.day}";
    else
      getEvent = getEvent + "${day.day}";
    // print(getEvent);
    return events[getEvent] ?? [];
  }

  void getCourseInfo(List<BookingInfo> input) {
    int durationHour = 0;
    int durationMinute = 0;

    for (var bookedCourse in input) {
      DateTime startTime = convertTimeStampToDate(
          bookedCourse.scheduleDetailInfo?.scheduleInfo?.startTimeStamp ?? 0);
      DateTime endTime = convertTimeStampToDate(
          bookedCourse.scheduleDetailInfo?.scheduleInfo?.endTimeStamp ?? 0);
      Duration duration = endTime.difference(startTime);
      durationHour = duration.inHours;
      durationMinute = duration.inMinutes;
      totalhours = totalhours + durationHour;
      totalminutes = totalminutes + durationMinute;
      // var addDate =
      //     new DateTime(startTime.year, startTime.month, startTime.day);
      String addDate = "";
      String id = bookedCourse.id ?? "";
      addDate = addDate + startTime.year.toString();
      if (startTime.month.toString().length < 2)
        addDate = addDate + "0${startTime.month}";
      else
        addDate = addDate + "${startTime.month}";
      if (startTime.day.toString().length < 2)
        addDate = addDate + "0${startTime.day}";
      else
        addDate = addDate + "${startTime.day}";
      // print(addDate);
      // print(DateTime.parse(addDate));
      String startMin = "";
      String endMin = "";
      if (startTime.minute.toString().length < 2)
        startMin = startMin + "0${startTime.minute}";
      else
        startMin = startMin + "${startTime.minute}";
      if (endTime.minute.toString().length < 2)
        endMin = endMin + "0${endTime.minute}";
      else
        endMin = endMin + "${endTime.minute}";
      // print("$addDate-${startTime.hour}-$startMin");
      events.addAll({
        addDate: events[addDate] != null
            ? [
                ...events[addDate]!,
                Event(addDate, startTime.hour, startMin, endTime.hour, endMin,
                    bookedCourse)
              ]
            : [
                Event(addDate, startTime.hour, startMin, endTime.hour, endMin,
                    bookedCourse)
              ],
      });
      // _selectedEvents.value = _getEventsForDay(addDate!);
    }
    setState(() {
      totalhours = totalhours + (totalminutes ~/ 60);
      totalminutes = totalminutes % 60;
      events;
      // print(events.length);

      // print(events);
    });
  }

  Future<void> showRemoveCourse(BookingInfo course) async {
    await showDialog(
      context: context,
      builder: (context) => ScheduleCancelingDialog(
        booking: course,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return Text("a");
    return _bookings == null
        ? const Center(child: CircularProgressIndicator())
        : Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text("Booked Sessions",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                            "Total Duration of Courses: $totalhours hour(s) $totalminutes minute(s)",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: TableCalendar(
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      // availableGestures: AvailableGestures.all,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      focusedDay: _focusedDay,
                      eventLoader: _getEventsForDay,
                      firstDay: DateTime.now(),
                      lastDay: DateTime(2025, 12, 31),
                      onDaySelected: _onDaySelected,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text("Courses in Date",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1000,
                    child: ValueListenableBuilder(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    showRemoveCourse(value[index].courseInfo);
                                  },
                                  title: Text(
                                      '${value[index].date.substring(0, 4)}-${value[index].date.substring(4, 6)}-${value[index].date.substring(6, 8)}'),
                                  subtitle: Text(
                                      '${value[index].startHour}:${value[index].startMinute} - ${value[index].endHour}:${value[index].endMinute}'),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
  }
}
