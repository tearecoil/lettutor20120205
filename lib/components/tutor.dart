import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import '../components/tutor_list.dart';
import 'package:lettutor20120205/homescreens-widgets/tutor_profile.dart';

class Tutor extends StatelessWidget {
  final String name;
  final String avatar;
  final String quotes;
  final double rating;
  final int rating_count;
  final String language;
  final String skill;

  Tutor(
      {required this.name,
      required this.avatar,
      required this.quotes,
      required this.rating,
      required this.rating_count,
      required this.language,
      required this.skill});

  String ratingCount() {
    return " (" + rating_count.toString() + ")";
  }

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
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => TutorProfile(
                        tutor: Tutor(
                      name: this.name,
                      avatar: this.avatar,
                      quotes: this.quotes,
                      rating: this.rating,
                      rating_count: this.rating_count,
                      language: this.language,
                      skill: this.skill,
                    )),
                  ),
                );
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
                                  avatar,
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
                                Row(
                                  children: [
                                    RatingBar(
                                      rating: rating,
                                    ),
                                    Text(
                                      ratingCount(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                // Image.asset(
                                //   "assets/images/newrate.png",
                                //   height: 100,
                                //   width: 100,
                                // ),
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
                                      child: Text(
                                        language,
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
                                      child: Text(
                                        skill,
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

Tutor ab = Tutor(
  name: "Kiryu Kazuma",
  avatar: "assets/images/ava1.png",
  quotes: "4th chairman of Tojo Clan",
  rating: 4.0,
  rating_count: 13,
  language: "Japanese",
  skill: "Dragon",
);

// TutorList 
