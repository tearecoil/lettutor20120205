import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/profile_box.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/tag.dart';
import 'package:lettutor20120205/components/tutor.dart';
import 'package:lettutor20120205/components/tutor_report.dart';
import 'package:lettutor20120205/models/schedule/schedule_api.dart';
import 'package:lettutor20120205/models/schedule/schedule_detail.dart';
import 'package:lettutor20120205/models/tutor/tutor_api.dart';
import 'package:lettutor20120205/models/tutor/tutor_info.dart';
import 'package:lettutor20120205/service-api/booking-services.dart';
import 'package:lettutor20120205/service-api/tutor-services.dart';
import 'package:lettutor20120205/tutor_pages/reviews.dart';
import 'package:lettutor20120205/utils/time_convert.dart';
import 'package:video_player/video_player.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/event.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  TutorInfo? tutor;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  Map<String, List<Schedule_api>>? _tutorSchedules;
  List<String>? scheduleHours;
  Map<DateTime, List<Event>> events = {};
  String? chosen;
  @override
  void initState() {
    super.initState();
    getTutorInfo();
    getTutorSchedule();
    _selectedDay = _focusedDay;
    setState(() {});
  }

  bool checkFavorite(TutorInfo checkTutor) {
    if (checkTutor.isFavorite == true) {
      // print("1");
      return true;
    } else {
      // print("0");
      return false;
    }
  }

  void getTutorSchedule() async {
    await BookingService.getTutorScheduleById(
        userID: widget.id,
        onSuccess: (schedules) {
          _tutorScheduleHandle(schedules);
        },
        onError: (message) {});
  }

  void _tutorScheduleHandle(List<Schedule_api> schedules) {
    schedules.removeWhere(
      (schedule) =>
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp ?? 0)
              .isBefore(DateTime.now()),
    );
    schedules.sort((schedule1, schedule2) =>
        schedule1.startTimestamp!.compareTo(schedule2.startTimestamp!));

    setState(() {
      for (var schedule in schedules) {
        final date =
            DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
        final dateKey = DateFormat('yyyy-MM-dd').format(date);
        _tutorSchedules ??= <String, List<Schedule_api>>{};
        if (_tutorSchedules?[dateKey] == null) {
          _tutorSchedules?[dateKey] = [];
        }
        _tutorSchedules?[dateKey]?.add(schedule);
      }
    });
  }

  void addFavorite(String userId) async {
    await TutorService.addFavorite(
      userId: userId,
      onSuccess: () {
        setState(() {
          tutor?.isFavorite = !(tutor?.isFavorite ?? false);
        });
      },
      onError: (message) {},
    );
  }

  void getTutorInfo() async {
    await TutorService.getTutorInformation(
        tutorID: widget.id,
        onSuccess: (tutorinfo) {
          tutor = tutorinfo;
          _videoPlayerController =
              VideoPlayerController.network(tutorinfo.video ?? '');
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            aspectRatio: 2 / 3,
            autoPlay: true,
          );
          setState(() {});
        },
        onError: (message) {
          // print(message);
        });
    // setState(() {

    // });
  }

  Future<void> showReport() async {
    await showDialog(
      context: context,
      builder: (context) => TutorReport(
        tutorId: tutor?.user?.id ?? "",
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        chosen = null;
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    }
  }

  void getHours(DateTime selectedDay) {
    MapEntry<String, List<Schedule_api>>? tempSchedule;
    List<Schedule_api> tutorSchedule = tempSchedule!.value ?? [];
  }

  void _tutorBookingHandle(String scheduleDetailId) async {
    await BookingService.bookClass(
      scheduleDetailIds: [scheduleDetailId],
      note: '',
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: EdgeInsets.all(16),
              height: 90,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Course booked",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "WE WILL LET YOU COOK",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      },
      onError: (message) {
        print("error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String name = tutor?.user?.name ?? "NO NAME";

    return tutor == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(tutor?.user?.avatar ??
                              "https://sandbox.api.lettutor.com/avatar/cb9e7deb-3382-48db-b07c-90acf52f541cavatar1686550060378.jpg"),
                          onBackgroundImageError: (exception, stackTrace) =>
                              const Icon(Icons.person_outline_rounded,
                                  size: 62),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar(
                        rating: tutor?.rating ?? 0,
                        ratingCount: tutor?.totalFeedback,
                      ),
                    ],
                  ),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    "Teacher",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text(
                    tutor?.user?.country ?? "DEFAULT COUNTRY",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          addFavorite(tutor!.user!.id!);
                          !checkFavorite(tutor!)
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Container(
                                      padding: EdgeInsets.all(16),
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Added to Favorite",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Reload this page to view your favorite list",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Container(
                                      padding: EdgeInsets.all(16),
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Removed to Favorite",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Reload this page to view your favorite list",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                );
                        },
                        icon: Icon(!checkFavorite(tutor!)
                            ? Icons.favorite
                            : Icons.favorite_border),
                        label: Text(
                            !checkFavorite(tutor!) ? "Favorite" : "Unfavorite"),
                      ),
                      TextButton.icon(
                          onPressed: () => showReport(),
                          icon: Icon(Icons.heart_broken),
                          label: Text("Report")),
                      TextButton.icon(
                          onPressed: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => Reviews(
                                  userID: tutor?.user?.id ?? "",
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.star),
                          label: const Text('Reviews')),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "VIDEO",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: _chewieController == null
                        ? Text(
                            'Loading...',
                          )
                        : Chewie(controller: _chewieController!),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "MY INFORMATION",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  ProfileBox(
                      text: tutor?.bio ?? "NOTHING", sectionName: "About me"),
                  SizedBox(height: 5),
                  ProfileBox(
                      text: tutor?.interests ?? "NOTHING",
                      sectionName: "Interests"),
                  SizedBox(height: 5),
                  ProfileBox(
                      text: tutor?.education ?? "NOTHING",
                      sectionName: "Education"),
                  SizedBox(height: 5),
                  ProfileBox(
                      text: tutor?.profession ?? "NOTHING",
                      sectionName: "Profession"),
                  SizedBox(height: 5),
                  ProfileBox(
                      text: tutor?.languages ?? "NOTHING",
                      sectionName: "Skill"),
                  SizedBox(height: 5),
                  Text(
                    "     Specialties",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      TagChip(
                        specialties: tutor?.specialties?.split(',') ?? [],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6, top: 10),
                        child: const Text(
                          "COURSES",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: CourseList().Course_List.length,
                            itemBuilder: (context, index) =>
                                CourseList().Course_List[index]),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _tutorSchedules == null
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 6, top: 10),
                                  child: const Text(
                                    "BOOK COURSES",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      chosen = null;
                                      scheduleHours = null;
                                    });
                                    //   chosen =
                                    //       scheduleHours?[0] ?? "no time today";
                                    // });
                                    // print('Day selected');
                                    // print(_selectedDay);
                                    String date = DateFormat('yyyy-MM-dd')
                                        .format(_selectedDay!);
                                    // print("Date - $date");
                                    List<Schedule_api>?
                                        schedulesOfSelectedDate =
                                        _tutorSchedules?[date];

                                    // print("Data-$schedulesOfSelectedDate");
                                    for (var schedule
                                        in schedulesOfSelectedDate!) {
                                      print(schedule.isBooked);
                                      if (schedule.isBooked == false) {
                                        if (scheduleHours == null) {
                                          scheduleHours = [];
                                        }
                                        scheduleHours?.add(
                                          '${convertTimeStampToHour(schedule.startTimestamp ?? 0)}'
                                          '-'
                                          '${convertTimeStampToHour(schedule.endTimestamp ?? 0)}',
                                        );
                                      }
                                    }
                                    setState(() {
                                      chosen = scheduleHours?[0];
                                    });
                                    ;
                                    // schedulesOfSelectedDate
                                    //     ?.forEach((schedule) {
                                    //   if (schedule.isBooked == false) {
                                    //     scheduleHours?.add(
                                    //       '${convertTimeStampToHour(schedule.startTimestamp ?? 0)}'
                                    //       '-'
                                    //       '${convertTimeStampToHour(schedule.endTimestamp ?? 0)}',
                                    //     );
                                    //   }
                                    // });
                                    print("Data after-$scheduleHours");
                                    // if (scheduleHours!.isEmpty) {
                                    //   scheduleHours = ["null"];
                                    // }
                                    int index = 0;
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Choose a time for course'),
                                              content: DropdownButton<String>(
                                                value: chosen,
                                                onChanged: (value) {
                                                  setState(() {
                                                    chosen = value.toString();
                                                    index = scheduleHours!
                                                        .indexOf(value!);
                                                  });
                                                },
                                                items:
                                                    scheduleHours?.map((value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("Cancel")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      if (chosen ==
                                                          "no time today") {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(16),
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Course can't be booked",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Please choose valid time for course",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            elevation: 0,
                                                          ),
                                                        );
                                                      } else {
                                                        _tutorBookingHandle(
                                                            schedulesOfSelectedDate?[
                                                                        index]
                                                                    .scheduleDetails?[
                                                                        0]
                                                                    .id ??
                                                                '');
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: Text("Submit")),
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
                                      backgroundColor: Colors.lightBlue,
                                      elevation: 5),
                                ),
                              ],
                            ),
                            SizedBox(
                              child: TableCalendar(
                                headerStyle: const HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                ),
                                availableGestures: AvailableGestures.all,
                                selectedDayPredicate: (day) =>
                                    isSameDay(_selectedDay, day),
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                focusedDay: _focusedDay,
                                // eventLoader: _getEventsForDay,
                                firstDay: DateTime.now(),
                                lastDay: DateTime(2025, 12, 31),
                                onDaySelected: _onDaySelected,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ));
  }
}
