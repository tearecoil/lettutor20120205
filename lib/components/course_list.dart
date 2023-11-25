import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_card.dart';

class CourseList {
  final List<CourseCard> Course_List = [
    CourseCard(
      index: 0,
      lesson: 5,
      title: "Tojo Clan",
      source: "assets/images/tojo.jpg",
      level: "Original Yakuza",
      overview: "Basic Information of Tojo Clan",
      chapter: [
        "Welcome to Tojo Clan",
        "Basic Families",
        "Ranking",
        "Founders and Chairmans",
        "Disbanded"
      ],
      tag: [
        "Basic information of Tojo Clan",
        "Main Families and Subsidiaries",
        "Lieutenant, Patriarch,...",
        "Lots of Dragon and the Dojima one",
        "Kamurocho 3K Plan and result "
      ],
      hours: 2,
      startHour: 6,
      startMinute: '30',
      //nextCourse: DateTime.now().add(const Duration(days: 1)),
    ),
    CourseCard(
      index: 1,
      lesson: 5,
      title: "Omi Alliance",
      source: "assets/images/omi.jpg",
      level: "Original Yakuza",
      overview: "Basic Information of Omi Alliance",
      chapter: [
        "Welcome to Omi Alliance",
        "Basic Families",
        "Ranking",
        "Founders and Chairmans",
        "Disbanded"
      ],
      tag: [
        "Basic information of Omi Alliance",
        "Main Families and Subsidiaries",
        "Lieutenant, Patriarch,...",
        "All the Infamous Leaders",
        "Kamurocho 3K Plan and result "
      ],
      hours: 2,
      startHour: 9,
      startMinute: '00',
      //nextCourse: DateTime.now().add(const Duration(days: 2)),
    ),
    CourseCard(
      index: 2,
      lesson: 4,
      title: "Yomei Alliance",
      source: "assets/images/yomei.jpg",
      level: "Retired Yakuza",
      overview: "Basic Information of Yomei Alliance",
      chapter: [
        "Welcome to Yomei Alliance",
        "Ranking",
        "Founders and Chairmans",
        "Secret of Onomichi"
      ],
      tag: [
        "Basic information of Yomei Alliance",
        "Main Families and Subsidiaries",
        "We keep the secret of...",
        "Not also a battleship",
      ],
      hours: 2,
      startHour: 11,
      startMinute: '11',
      //nextCourse: DateTime.now().add(const Duration(days: 3)),
    ),
    CourseCard(
      index: 3,
      lesson: 1,
      title: "Daidoji Faction",
      source: "assets/images/daidoji.jpg",
      level: "Like A Dragon",
      overview: "Basic Information of Daidoji Faction",
      chapter: ["The Secret Clan"],
      tag: ["Erase your name and get a new life"],
      hours: 1,
      startHour: 14,
      startMinute: '30',
      //nextCourse: DateTime.now().add(const Duration(days: 4)),
    ),
    CourseCard(
      index: 4,
      lesson: 4,
      title: "Seiryu Clan",
      source: "assets/images/seiryu.jpg",
      level: "Like A Dragon",
      overview: "Basic Information of Seiryu Clan",
      chapter: [
        "Welcome to Seiryu Clan",
        "Ranking",
        "Founders and Chairmans",
        "Rivalry and Friendship in Yokohama"
      ],
      tag: [
        "Basic information of Seiryu Clan",
        "Main Families and Subsidiaries",
        "1 of 3 Yokohama Power Leaders",
        "Balance in all things",
      ],
      hours: 3,
      startHour: 18,
      startMinute: '30',
      //nextCourse: DateTime.now().add(const Duration(days: 5)),
    ),
  ];
}
