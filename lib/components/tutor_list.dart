import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/tutor.dart';

class TutorList {
  final List<Widget> tutorlist = [
    Tutor(
      name: "Kiryu Kazuma",
      avatar: "assets/images/ava1.png",
      quotes: "4th chairman of Tojo Clan",
      rating: 4.0,
      rating_count: 13,
      language: "Japanese",
      skill: "Dragon",
    ),
    Tutor(
      name: "Joryu",
      avatar: "assets/images/ava3.jpg",
      quotes: "Daidoji Faction's Agent",
      rating: 5.0,
      rating_count: 3,
      language: "Japanese",
      skill: "Agent",
    ),
    Tutor(
      name: "Kihei Hanawa",
      avatar: "assets/images/ava4.png",
      quotes: "Daidoji Faction's Agent",
      rating: 4.6,
      rating_count: 1,
      language: "Japanese",
      skill: "Agent",
    ),
    Tutor(
      name: "Taiga Saejima",
      avatar: "assets/images/ava5.png",
      quotes: "Saejima Family Patriarch",
      rating: 0,
      rating_count: 18,
      language: "Japanese",
      skill: "18-counts",
    ),
    Tutor(
      name: "Daigo Dojima",
      avatar: "assets/images/ava6.png",
      quotes: "6th chairman of Tojo Clan",
      rating: 5,
      rating_count: 30000,
      language: "Japanese",
      skill: "Charisma",
    ),
    Tutor(
      name: "Ichiban Kasuga",
      avatar: "assets/images/ava7.png",
      quotes: "Hero - Former Arakawa Family Member",
      rating: 2.3,
      rating_count: 10,
      language: "Japanese",
      skill: "Hero",
    ),
    Tutor(
      name: "Goro Majima",
      avatar: "assets/images/ava2.jpg",
      quotes: "Majima Family Patriarch",
      rating: 3.1,
      rating_count: 99,
      language: "Japanese",
      skill: "Mad Dog",
    ),
  ];
}
