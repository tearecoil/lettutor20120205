import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/rating_bar.dart';

DateTime now = DateTime.now();
String convertedDateTime =
    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

class HistoryCard extends StatelessWidget {
  final String name;
  final String ava;
  final String couname;
  final String coupic;
  HistoryCard(
      {required this.name,
      required this.ava,
      required this.couname,
      required this.coupic});

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
        child: InkWell(
          onTap: () {},
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
                                  ava,
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
                              coupic,
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              couname,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10)),
                            GestureDetector(
                                child: Text(
                                  "Add a rating",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blue),
                                ),
                                onTap: () {}),
                          ],
                        ),

                        // SizedBox(width: 25),
                        RatingBar(
                          rating: 0,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
