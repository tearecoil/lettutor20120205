import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/tutor_list.dart';

class ScheduledCourse extends StatelessWidget {
  final String name;
  final String avatar;
  final String in_time;
  final String out_time;

  ScheduledCourse(
      {required this.name,
      required this.avatar,
      required this.in_time,
      required this.out_time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 10,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              "assets/images/tutor_pic.png",
                              width: 100,
                              height: 100,
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 0),
                              child: Column(
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5, right: 8),
                                  padding: EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Text(
                                    in_time,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5, right: 8),
                                  padding: EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Text(
                                    out_time,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                        child: Column(
                      children: [
                        Image.asset(
                          "assets/images/ava.png",
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          "Teacher K",
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "VietNam",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
