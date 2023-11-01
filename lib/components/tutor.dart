import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tutor extends StatelessWidget {
  final String name;
  final String avatar;
  final String quotes;

  Tutor({required this.name, required this.avatar, required this.quotes});

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
          elevation: 1,
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/tutorpro");
              },
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
                                  "assets/images/ava.png",
                                  width: 100,
                                  height: 100,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 0),
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/newrate.png",
                                  height: 100,
                                  width: 100,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 5, right: 8),
                                      padding: EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: const Text(
                                        "Language",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5, right: 8),
                                      padding: EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: const Text(
                                        "Skills",
                                        style: TextStyle(
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
                        Icon(Icons.thumb_up_sharp)
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        quotes,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
