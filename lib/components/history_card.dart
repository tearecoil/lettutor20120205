import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

DateTime now = DateTime.now();
String convertedDateTime =
    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

class HistoryCard extends StatelessWidget {
  final String name;

  HistoryCard({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 1,
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(convertedDateTime,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text("0 sec ago",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset(
                                "assets/images/ava.png",
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
                                      "Teacher K",
                                      style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Image.asset(
                            "assets/images/tutor_pic.png",
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          // Text(
                          //   "VietNam",
                          //   style: const TextStyle(
                          //       fontSize: 12, fontWeight: FontWeight.w600),
                          // ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Row(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 50,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text(
                          "Lession Review",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          "No reviews yet",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 30,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          "Add a rating",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
