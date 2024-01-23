import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({Key? key}) : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  Timer? _timerInRoom;
  Timer? _timerToStart;

  int _countTimeInRoom = 0;
  int _countTimeToStart = 15 * 60 * 60;

  void increase(timer) {
    setState(() {
      _countTimeInRoom++;
    });
  }

  void descrease(timer) {
    setState(() {
      if (_countTimeToStart > 0) {
        _countTimeToStart--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _timerInRoom = Timer.periodic(const Duration(seconds: 1), (timer) {
      increase(timer);
    });

    _timerToStart = Timer.periodic(const Duration(seconds: 1), (timer) {
      descrease(timer);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timerInRoom?.cancel();
    _timerToStart?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.black,
    ));
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Tutorial Meeting Room ${stringDuration(Duration(seconds: _countTimeInRoom))}",
                      style: TextStyle(color: Colors.grey[100], fontSize: 13),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Image.asset("assets/images/my_ava.jpg"),
                        ),
                      ],
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 50,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

String stringDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours <= 0) return "$twoDigitMinutes : $twoDigitSeconds";
  return "${twoDigits(duration.inHours)} : $twoDigitMinutes : $twoDigitSeconds";
}
