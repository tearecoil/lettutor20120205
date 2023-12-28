import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor20120205/models/schedule/booking_info.dart';
import 'package:lettutor20120205/models/schedule/schedule_info.dart';
import 'package:lettutor20120205/utils/time_convert.dart';

class LessonDialog extends StatelessWidget {
  const LessonDialog({super.key, this.booking, this.child, this.onSubmit});

  final BookingInfo? booking;
  final Widget? child;
  final Future<String?> Function()? onSubmit;

  void _showSuccessfulMessageDialog(BuildContext context) async {
    final String? message = await onSubmit!();
    if (message != null) {
      double? value = double.tryParse(message);
      if (value != null) {
        if (context.mounted) {
          Navigator.of(context).pop(value);
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).pop(message);
        }
      }
    } else {
      if (context.mounted) {
        Navigator.of(context).pop(false);
      }
    }
  }

  String getCourseTime(DateTime StartTime, DateTime EndTime) {
    String addTime = "";
    String startMin = "";
    String endMin = "";
    if (StartTime.minute.toString().length < 2)
      startMin = startMin + "0${StartTime.minute}";
    else
      startMin = startMin + "${StartTime.minute}";
    if (EndTime.minute.toString().length < 2)
      endMin = endMin + "0${EndTime.minute}";
    else
      endMin = endMin + "${EndTime.minute}";
    addTime =
        addTime + "${StartTime.hour}:${startMin} - ${EndTime.hour}:${endMin}";
    return addTime;
  }

  String getCourseDate(DateTime StartTime) {
    String addDate = "";
    addDate = addDate + StartTime.year.toString() + "-";
    if (StartTime.month.toString().length < 2)
      addDate = addDate + "0${StartTime.month}";
    else
      addDate = addDate + "${StartTime.month}";
    addDate = addDate + "-";
    if (StartTime.day.toString().length < 2)
      addDate = addDate + "0${StartTime.day}";
    else
      addDate = addDate + "${StartTime.day}";
    return addDate;
  }

  @override
  Widget build(BuildContext context) {
    final ScheduleInfo? scheduleInfo =
        booking?.scheduleDetailInfo?.scheduleInfo;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 20,
          children: <Widget>[
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 62,
                    height: 62,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: scheduleInfo?.tutorInfo?.avatar ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 62,
                      ),
                    ),
                  ),
                ),
                Text(
                  scheduleInfo?.tutorInfo?.name ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                const Text('Lesson Time', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 2),
                Text(getCourseDate(convertTimeStampToDate(
                    booking?.scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
                        0))),
                Text(getCourseTime(
                  convertTimeStampToDate(booking
                          ?.scheduleDetailInfo?.scheduleInfo?.startTimeStamp ??
                      0),
                  convertTimeStampToDate(
                      booking?.scheduleDetailInfo?.scheduleInfo?.endTimeStamp ??
                          0),
                ))
                // Text(
                //   '${convertTimeStampToDay(scheduleInfo?.startTimeStamp ?? 0)}, '
                //   '${TimeHelper.convertTimeStampToHour(scheduleInfo?.startTimeStamp ?? 0)}'
                //   ' - '
                //   '${TimeHelper.convertTimeStampToHour(scheduleInfo?.endTimeStamp ?? 0)}',
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
              ],
            ),
            const Divider(height: 1),
            child!
          ],
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text(
            'Later',
          ),
        ),
        TextButton(
          onPressed: () {
            _showSuccessfulMessageDialog(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue[700],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
