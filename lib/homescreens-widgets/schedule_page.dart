import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/scheduled_course_list.dart';
import 'package:lettutor20120205/components/event_add.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../components/tutor_list.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

List<Meeting> meeting = <Meeting>[];
int? totalhours;

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    getTotalHours();
  }

  void getTotalHours() async {
    int hrs_temp = 0;
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    List<String>? temp = sharedpref.getStringList('schedule') ?? [];
    for (int i = 0; i < CourseList().Course_List.length; i++) {
      hrs_temp = hrs_temp + CourseList().Course_List[i].hours;
    }
    totalhours = hrs_temp;
    // for (int i = 0; i < CourseList().Course_List.length; i++) {
    //   if (temp[i] == "True") {
    //     print("$i");
    //     print("${CourseList().Course_List[i].hours}");
    //     hrs_temp = hrs_temp + CourseList().Course_List[i].hours;
    //     print("$totalhours");
    //     meeting.add(Meeting(
    //       CourseList().Course_List[i].title,
    //       CourseList().Course_List[i].nextCourse,
    //       CourseList()
    //           .Course_List[i]
    //           .nextCourse
    //           .add(Duration(hours: CourseList().Course_List[i].hours)),
    //       CourseList().Course_List[i].hours,
    //     ));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    //return Text("a");
    return Column(
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
          height: 2000,
          child: SfCalendar(
            view: CalendarView.week,
            dataSource: MeetingDataSource(getAppointments()),
          ),
        ),
      ],
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  for (int i = 0; i < CourseList().Course_List.length; i++) {
    String subject = CourseList().Course_List[i].title;
    DateTime startTime = CourseList().Course_List[i].nextCourse;
    DateTime endTime =
        startTime.add(Duration(hours: CourseList().Course_List[i].hours));

    meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: subject,
      color: Colors.lightBlue,
    ));
  }
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
