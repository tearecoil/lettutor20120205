import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lettutor20120205/models/schedule/booking_info.dart';
import 'package:lettutor20120205/models/schedule/schedule_info.dart';
import 'package:lettutor20120205/service-api/booking-services.dart';
import 'package:lettutor20120205/service-api/call-services.dart';
import 'package:lettutor20120205/utils/time_convert.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int? _totalCall;
  BookingInfo? _bookingInfo;
  ScheduleInfo? _nextLesson;
  Timer? _timer;
  Duration? _currentTime;
  DateTime _timeStamp = DateTime.now();

  String? _studentMeetingLink;
  final _jitsiMeetPlugin = JitsiMeet();

  @override
  void initState() {
    super.initState();
    _getMostUpcommingLesson();
    _getTotalCall();
  }

  bool _checkLessonStart() {
    if (_timeStamp.isBefore(DateTime.now())) {
      return false;
    } else {
      return true;
    }
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_currentTime?.inSeconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _currentTime = _checkLessonStart()
                ? _timeStamp.difference(DateTime.now())
                : DateTime.now().difference(_timeStamp);
          });
        }
      },
    );
  }

  void _getMostUpcommingLesson() async {
    await BookingService.getTutorNextBookingList(
        onSuccess: (schedules) {
          if (schedules.isEmpty) return;

          schedules.removeWhere((schedule) =>
              DateTime.fromMillisecondsSinceEpoch(schedule
                          .scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
                      0)
                  .isBefore(DateTime.now()));

          schedules.sort((soonSchedule, laterSchedule) {
            final soonScheduleTimeStamp =
                soonSchedule.scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
                    0;
            final laterScheduleTimeStamp = laterSchedule
                    .scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
                0;
            return soonScheduleTimeStamp.compareTo(laterScheduleTimeStamp);
          });

          setState(() {
            _bookingInfo = schedules.first;
            _nextLesson = schedules.first.scheduleDetailInfo?.scheduleInfo;
            _timeStamp = DateTime.fromMillisecondsSinceEpoch(
              _nextLesson?.startTimeStamp ?? 0,
            );

            _studentMeetingLink = _bookingInfo?.studentMeetingLink;
            _timeStamp = DateTime.fromMillisecondsSinceEpoch(_bookingInfo
                    ?.scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
                0);

            _startTimer();
          });
        },
        onError: (message) {});
  }

  void _getTotalCall() async {
    await CallService.getTotalCall(
        onSuccess: (total) {
          setState(() {
            _totalCall = total;
          });
        },
        onError: (message) => {});
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _joinMeeting() async {
    final String meetingToken = _studentMeetingLink?.split('token=')[1] ?? '';

    print(meetingToken);

    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
    final String room = jwtDecoded['room'];

    var options = JitsiMeetConferenceOptions(
      serverURL: "https://meet.lettutor.com",
      room: room,
      token: meetingToken,
      featureFlags: {
        "call-integration.enabled": false,
      },
    );

    try {
      await _jitsiMeetPlugin.join(options);
    } catch (error) {}
  }

  Widget welcomeWidget() {
    return const Column(
      children: <Widget>[
        SizedBox(height: 18),
        Text(
          'You have ',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 18),
        Text(
          'Welcome to Lettutor',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget upcomingLessonWidget() {
    if (_nextLesson == null) {
      return const Text(
        'You have no upcoming lesson.',
        style: TextStyle(color: Colors.white),
      );
    }

    final date = convertTimeStampToDay(_nextLesson?.startTimeStamp ?? 0);

    final time = '${convertTimeStampToHour(_nextLesson?.startTimeStamp ?? 0)}'
        ' - '
        '${convertTimeStampToHour(_nextLesson?.endTimeStamp ?? 0)}';

    return Column(
      children: <Widget>[
        const Text(
          'Upcomming Lesson',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          '$date $time',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          '${_checkLessonStart() ? '(starts in ' : '(is in progress for '}'
          '${getRemainingTimer(_currentTime ?? Duration.zero)})',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: _checkLessonStart() ? Colors.yellow : Colors.blue.shade300,
          ),
        ),
        const SizedBox(height: 18),
        TextButton(
          onPressed: _joinMeeting,
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.ondemand_video_rounded,
                color: Colors.blue[500],
              ),
              const SizedBox(width: 14),
              Text(
                'Enter Lesson Room',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final hour = (_totalCall ?? 0) ~/ 60;
    final minute = (_totalCall ?? 0) % 60;

    return Container(
      color: Colors.blue[300],
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 18),
          upcomingLessonWidget(),
          const SizedBox(height: 18),
          Text(
            _totalCall == 0
                ? 'Welcome to Lettutor'
                : 'Total Lesson Time: $hour hours $minute minutes',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
