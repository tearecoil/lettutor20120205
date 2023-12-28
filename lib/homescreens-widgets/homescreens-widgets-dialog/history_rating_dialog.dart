import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/lesson_rating_dialog.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/star_rating.dart';
import 'package:lettutor20120205/models/schedule/booking_info.dart';
import 'package:lettutor20120205/models/tutor/tutor_review.dart';
import 'package:lettutor20120205/service-api/user-services.dart';
//import 'package:lettutor20120205/widgets/star_rating.dart';

class HistoryRatingDialog extends StatefulWidget {
  const HistoryRatingDialog({super.key, required this.booking});

  final BookingInfo booking;
  // final ReviewTutor? feedback;

  @override
  State<HistoryRatingDialog> createState() => _HistoryRatingDialogState();
}

class _HistoryRatingDialogState extends State<HistoryRatingDialog> {
  final TextEditingController _reviewTextEditingController =
      TextEditingController();
  double? _rating;

  late final BookingInfo booking;

  @override
  void initState() {
    super.initState();
    booking = widget.booking;
    _rating = 0;
    _reviewTextEditingController.text = '';
  }

  Future<String?> _handleRatingSubmit() async {
    final response = await UserService.feedbackTutor(
      bookingId: booking.id ?? '',
      userId: booking.userId ?? '',
      rating: _rating as int,
      content: _reviewTextEditingController.text,
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
                    "Review sent successfully",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Thank you for your opinion on Tutor and Course",
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
        return _rating.toString();
      },
      onError: (message) {},
    );

    return response;
  }

  @override
  void dispose() {
    super.dispose();
    _reviewTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LessonDialog(
      booking: booking,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'What is your rating for ${booking.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name}?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 14),
          StarRating(
            rating: _rating ?? 0,
            onRatingChanged: (value) => setState(() {
              _rating = value;
            }),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: TextField(
              maxLines: null,
              expands: true,
              controller: _reviewTextEditingController,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {},
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                hintText: 'Your detail reviews',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onSubmit: () async {
        return await _handleRatingSubmit();
      },
    );
  }
}
