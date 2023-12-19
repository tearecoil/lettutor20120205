import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import '../components/tutor_list.dart';
// import 'package:lettutor20120205/tutor_pages/view_tutor_profile.dart';

class Tutor extends StatelessWidget {
  final String name;
  final String avatar;
  final String quotes;
  final String education;
  final double rating;
  final int rating_count;
  final String language;
  final String skill;
  final String nationality;
  bool favorite = false;

  Tutor(
      {required this.name,
      required this.avatar,
      required this.quotes,
      required this.education,
      required this.rating,
      required this.rating_count,
      required this.language,
      required this.skill,
      required this.nationality,
      required this.favorite});

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
                // Navigator.push<void>(
                //   context,
                //   MaterialPageRoute<void>(
                //     builder: (BuildContext context) => TutorProfile(
                //         tutor: Tutor(
                //       name: this.name,
                //       avatar: this.avatar,
                //       quotes: this.quotes,
                //       education: this.education,
                //       rating: this.rating,
                //       rating_count: this.rating_count,
                //       language: this.language,
                //       skill: this.skill,
                //       nationality: this.nationality,
                //       favorite: favorite,
                //     )),
                //   ),
                // );
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
                                  child: Row(
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        " (" + nationality + ")",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  // child: Text(
                                  //   name ,
                                  //   style: const TextStyle(
                                  //       fontSize: 23,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
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
                        IconButton(
                          onPressed: () {
                            favorite = !favorite;
                            if (favorite == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Container(
                                    padding: EdgeInsets.all(16),
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Remove from Favorite",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "You can recheck the list",
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Container(
                                    padding: EdgeInsets.all(16),
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Add to Favorite",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "You can recheck the list",
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
                            }
                          },
                          icon: Icon(Icons.favorite),
                        ),
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

// Tutor ab = Tutor(
//   name: "Kiryu Kazuma",
//   avatar: "assets/images/ava1.png",
//   quotes: "4th chairman of Tojo Clan",
//   rating: 4.0,
//   rating_count: 13,
//   language: "Japanese",
//   skill: "Dragon",
// );

// TutorList 
