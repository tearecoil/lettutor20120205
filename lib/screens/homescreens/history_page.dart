import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor20120205/components/history_list.dart';
import 'package:lettutor20120205/components/profile_box.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/widgets/homescreens-widgets-dialog/history_rating_dialog.dart';
import 'package:lettutor20120205/widgets/homescreens-widgets-dialog/history_report_dialog.dart';
import 'package:lettutor20120205/models/schedule/booking_info.dart';
import 'package:lettutor20120205/service-api/booking-services.dart';
import 'package:lettutor20120205/utils/time_convert.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<BookingInfo>? _bookings;

  @override
  void initState() {
    super.initState();
    _getBookingListByStudent();
  }

  void _getBookingListByStudent() async {
    await BookingService.getBookingListByStudent(
        page: 1,
        perPage: 10,
        inFuture: 0,
        sortBy: 'desc',
        onSuccess: (bookings) {
          setState(() {
            _bookings = bookings;
          });
        },
        onError: (message) {});
  }

  int getDuration(DateTime time) {
    DateTime now = DateTime.now();
    Duration duration = now.difference(time);
    int durationHour = duration.inHours;
    return durationHour;
  }

  String getCourseDate(DateTime time) {
    String addDate = "";
    addDate = addDate + time.year.toString() + "-";
    if (time.month.toString().length < 2)
      addDate = addDate + "0${time.month}";
    else
      addDate = addDate + "${time.month}";
    addDate = addDate + "-";
    if (time.day.toString().length < 2)
      addDate = addDate + "0${time.day}";
    else
      addDate = addDate + "${time.day}";
    return addDate;
  }

  Future<void> _showHistoryRatingDialog(
      BuildContext context, BookingInfo booking) async {
    await showDialog(
        context: context,
        builder: (context) {
          return HistoryRatingDialog(
            booking: booking,
          );
        });
  }

  Future<void> showReportCourse(
      BuildContext context, BookingInfo course) async {
    await showDialog(
      context: context,
      builder: (context) => ReportCourseDialog(
        booking: course,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _bookings == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 25, bottom: 10, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text("History",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: ListView.builder(
                  itemCount: _bookings!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                      child: Card(
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 1,
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: CircleAvatar(
                                                radius: 45,
                                                backgroundImage: NetworkImage(
                                                    _bookings?[index]
                                                            .scheduleDetailInfo
                                                            ?.scheduleInfo
                                                            ?.tutorInfo
                                                            ?.avatar ??
                                                        "https://sandbox.api.lettutor.com/avatar/cb9e7deb-3382-48db-b07c-90acf52f541cavatar1686550060378.jpg"),
                                                onBackgroundImageError: (exception,
                                                        stackTrace) =>
                                                    const Icon(
                                                        Icons
                                                            .person_outline_rounded,
                                                        size: 62),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        _bookings?[index]
                                                                .scheduleDetailInfo
                                                                ?.scheduleInfo
                                                                ?.tutorInfo
                                                                ?.name ??
                                                            "no name",
                                                        style: const TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                    getCourseDate(convertTimeStampToDate(
                                                        _bookings![index]
                                                                .scheduleDetailInfo
                                                                ?.scheduleInfo
                                                                ?.startTimeStamp ??
                                                            0)),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "   ${getDuration(convertTimeStampToDate(_bookings![index].scheduleDetailInfo?.scheduleInfo?.startTimeStamp ?? 0))} hour(s) ago",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            // Column(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: [
                                            //     Container(
                                            //       margin: EdgeInsets.only(
                                            //           bottom: 0),
                                            //       child: Column(
                                            //         children: [
                                            //           Text(
                                            //             name,
                                            //             style: const TextStyle(
                                            //                 fontSize: 23,
                                            //                 fontWeight:
                                            //                     FontWeight
                                            //                         .bold),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ],
                                            // )
                                          ],
                                        ),
                                        // Container(
                                        //   child: Column(
                                        //     children: [
                                        //       SizedBox(
                                        //         height: 25,
                                        //       ),
                                        //       Image.asset(
                                        //         coupic,
                                        //         width: 50,
                                        //         height: 50,
                                        //       ),
                                        //       Text(
                                        //         couname,
                                        //         style: const TextStyle(
                                        //             fontSize: 23,
                                        //             fontWeight:
                                        //                 FontWeight.bold),
                                        //       ),
                                        //       // Text(
                                        //       //   "VietNam",
                                        //       //   style: const TextStyle(
                                        //       //       fontSize: 12, fontWeight: FontWeight.w600),
                                        //       // ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Row(),
                              Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 25),
                                    ProfileBox(
                                        text:
                                            _bookings?[index].studentRequest ??
                                                "NO REQUEST",
                                        sectionName: "Request for Lesson"),
                                    // Container(
                                    //   height: 50,
                                    //   child: Row(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     children: [
                                    //       Padding(
                                    //           padding:
                                    //               EdgeInsets.only(left: 5)),
                                    //       Text(
                                    //         "Request for Lesson",
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 25),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // Container(
                                    //   height: 30,
                                    //   child: Row(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     children: [
                                    //       Padding(
                                    //           padding:
                                    //               EdgeInsets.only(left: 10)),
                                    //       Text(
                                    //         _bookings[index].studentRequest ??
                                    //             "NO REQUEST",
                                    //         style: TextStyle(
                                    //           fontSize: 18,
                                    //           color: Colors.grey[200],
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                    ProfileBox(
                                        text: _bookings?[index].tutorReview ??
                                            "NO REVIEW",
                                        sectionName: "Tutor's review"),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        new Spacer(),
                                        ActionChip(
                                          backgroundColor: Colors.lightBlue,
                                          label: Text(
                                            "Add a rating",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            _showHistoryRatingDialog(
                                                context,
                                                _bookings![
                                                    index]); // await TutorService.getTutorwithFilters(
                                            //     page: 1,
                                            //     perPage: 10,
                                            //     specialties: [special?.key ?? ""],
                                            //     onSuccess: (tutors) {
                                            //       _tutors = tutors.toList();
                                            //       setState(() {});
                                            //     },
                                            //     onError: (message) {});
                                          },
                                        ),
                                        SizedBox(width: 5),
                                        ActionChip(
                                          backgroundColor: Colors.black,
                                          label: Text(
                                            "Report",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            showReportCourse(
                                                context, _bookings![index]);
                                            // await TutorService.getTutorwithFilters(
                                            //     page: 1,
                                            //     perPage: 10,
                                            //     specialties: [special?.key ?? ""],
                                            //     onSuccess: (tutors) {
                                            //       _tutors = tutors.toList();
                                            //       setState(() {});
                                            //     },
                                            //     onError: (message) {});
                                          },
                                        ),
                                      ],
                                    ),
                                    // Container(
                                    //   height: 30,
                                    //   child: Row(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Row(
                                    //         children: [
                                    //           Padding(
                                    //               padding: EdgeInsets.only(
                                    //                   left: 10)),
                                    //           GestureDetector(
                                    //               child: Text(
                                    //                 "Add a rating",
                                    //                 textAlign: TextAlign.left,
                                    //                 style: TextStyle(
                                    //                     fontSize: 18,
                                    //                     color: Colors.blue),
                                    //               ),
                                    //               onTap: () {}),
                                    //         ],
                                    //       ),

                                    //       // SizedBox(width: 25),
                                    //       RatingBar(
                                    //         rating: 0,
                                    //         size: 20,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ],
          );
  }
}
