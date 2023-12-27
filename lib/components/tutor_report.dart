import 'package:flutter/material.dart';
import 'package:lettutor20120205/service-api/tutor-services.dart';

class TutorReport extends StatefulWidget {
  const TutorReport({super.key, required this.tutorId});

  final String tutorId;

  @override
  State<TutorReport> createState() => _TutorReport();
}

class _TutorReport extends State<TutorReport> {
  final _reportTextEditingController = TextEditingController();
  final Map<String, bool> _reports = {
    'Courses are not as described': false,
    'This profile is pretending be someone or is fake': false,
    'Tutor failed as giving courses': false
  };

  void trackReport() {
    _reports.updateAll((key, value) => false);
    final data = _reportTextEditingController.text.split('\n');
    for (final report in data) {
      if (_reports.containsKey(report)) {
        _reports.update(report, (value) => true);
      }
    }
  }

  void handleSubmitted() async {
    await TutorService.reportTutor(
      userId: widget.tutorId,
      content: _reportTextEditingController.text,
      onSuccess: () {
        Navigator.pop(context, true);
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
                    "Report sent successfully",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Sorry for your bad experience with Tutor",
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
      onError: (message) {},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _reportTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Column(
        children: <Widget>[
          Text(
            'What was wrong with your experience?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 6),
          const Divider(height: 1),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.report_rounded, color: Colors.blue[700]),
              const SizedBox(width: 4),
              const Text(
                "Please state your problems",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: List<Widget>.generate(
                _reports.length,
                (index) => CheckboxListTile(
                  title: Text(
                    _reports.keys.elementAt(index),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: _reports.values.elementAt(index),
                  onChanged: (value) {
                    setState(() {
                      _reports.update(
                          _reports.keys.elementAt(index), (value) => !value);
                      // if (_reports.values.elementAt(index)) {
                      //   _reportTextEditingController.text =
                      //       '${_reportTextEditingController.text}${_reports.keys.elementAt(index)}\n';
                      // } else {
                      //   _reportTextEditingController.text =
                      //       _reportTextEditingController.text.replaceAll(
                      //           '${_reports.keys.elementAt(index)}\n', '');
                      // }
                    });
                  },
                  side: const BorderSide(width: 0.5, color: Colors.blue),
                  activeColor: Colors.blue[500],
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: TextField(
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              controller: _reportTextEditingController,
              onChanged: (value) {
                trackReport();
              },
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
                hintText: 'Other problems need to be stated',
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(100, 38),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            side: BorderSide(
              width: 1.5,
              color: Colors.blue[700]!,
            ),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
            ),
          ),
        ),
        TextButton(
          onPressed: handleSubmitted,
          style: TextButton.styleFrom(
            fixedSize: const Size(100, 38),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blue[700],
          ),
          child: const Text(
            'Submit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
