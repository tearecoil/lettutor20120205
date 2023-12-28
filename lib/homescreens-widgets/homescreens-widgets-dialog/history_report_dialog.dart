import 'package:flutter/material.dart';
import 'package:lettutor20120205/models/schedule/booking_info.dart';
import 'package:lettutor20120205/service-api/booking-services.dart';

class ReportCourseDialog extends StatefulWidget {
  const ReportCourseDialog({super.key, required this.booking});

  final BookingInfo booking;

  @override
  State<ReportCourseDialog> createState() => ReportCourseDialogState();
}

const reasons = [
  'Tutor was late',
  'Course was not as description',
  'Instruction did not reach me',
  'Other'
];

class ReportCourseDialogState extends State<ReportCourseDialog> {
  final TextEditingController _noteTextEditingController =
      TextEditingController();
  String _selectedReason = reasons.first;
  void initState() {
    super.initState();
    // print("1");
  }

  @override
  void dispose() {
    super.dispose();
    _noteTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Please state your problems',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 14),
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: reasons
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: _selectedReason,
                onChanged: (String? value) {
                  setState(() {
                    _selectedReason = value!;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 140,
            child: TextField(
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              controller: _noteTextEditingController,
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
                hintText: 'Additional Notes',
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
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
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
          onPressed: () async {
            final isSuccess = true;
            if (isSuccess == true) {
              print(true);
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
                          "Report course successfully",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "We will take a look, sorry for your bad experience",
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
            } else {
              print(false);
            }

            Navigator.pop(context, true);
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
