// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/event.dart';
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
  late String chosen;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  List<String> CourseName = [] ?? ['no one'];
  late final ValueNotifier<List<Event>> _selectedEvents;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    setCourseNamefromList();
    chosen = CourseName[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setCourseNamefromList() {
    for (var course in CourseList().Course_List) {
      CourseName.add(course.title);
    }
    // print(CourseName);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  int searchHour(String query) {
    final SearchByName = CourseList().Course_List.where((course) {
      final courseName = course.title.toLowerCase();
      final input = query.toLowerCase();
      // final tutorName = tutor.name.toLowerCase();
      return courseName.contains(input);
    }).first;
    return SearchByName.startHour;
  }

  String searchMinute(String query) {
    final SearchByName = CourseList().Course_List.where((course) {
      final courseName = course.title.toLowerCase();
      final input = query.toLowerCase();
      // final tutorName = tutor.name.toLowerCase();
      return courseName.contains(input);
    }).first;
    return SearchByName.startMinute;
  }

  int searchDuration(String query) {
    final SearchByName = CourseList().Course_List.where((course) {
      final courseName = course.title.toLowerCase();
      final input = query.toLowerCase();
      // final tutorName = tutor.name.toLowerCase();
      return courseName.contains(input);
    }).first;
    return SearchByName.hours;
  }

  @override
  Widget build(BuildContext context) {
    //return Text("a");
    return Container(
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
                  child: Text("Total Hours: $totalhours",
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
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                startingDayOfWeek: StartingDayOfWeek.monday,
                focusedDay: _focusedDay,
                eventLoader: _getEventsForDay,
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime(2025, 12, 31),
                onDaySelected: _onDaySelected,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              title: Text('Choose a Course to add to this day'),
                              content: DropdownButton<String>(
                                value: chosen,
                                onChanged: (value) {
                                  setState(() {
                                    chosen = value.toString();
                                  });
                                },
                                items: CourseName.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        totalhours =
                                            totalhours + searchDuration(chosen);
                                      });
                                      events.addAll({
                                        _selectedDay!: [
                                          Event(
                                              chosen,
                                              searchHour(chosen),
                                              searchMinute(chosen),
                                              searchDuration(chosen))
                                        ]
                                      });
                                      Navigator.of(context).pop();
                                      _selectedEvents.value =
                                          _getEventsForDay(_selectedDay!);
                                    },
                                    child: Text("Submit"))
                              ],
                            );
                          });
                        });
                  },
                  child: Text(
                    'Add event',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue, elevation: 5),
                ),
              ],
            ),
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
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () => print(""),
                            title: Text('${value[index].title}'),
                            subtitle: Text(
                                '${value[index].startHour}:${value[index].startMinute} - ${value[index].startHour + value[index].duration}:${value[index].startMinute}'),
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
