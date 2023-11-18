import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor20120205/components/tutor.dart';
import '../components/tutor_list.dart';

class TutorHomePage extends StatefulWidget {
  const TutorHomePage({super.key});

  @override
  State<TutorHomePage> createState() => _TutorHomePageState();
}

DateTime now = DateTime.now();
String convertedDateTime =
    "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

class _TutorHomePageState extends State<TutorHomePage> {
  final searchCon = TextEditingController();
  List<Tutor> tutorlist = TutorList().tutorlist.toList();
  List<Tutor> resettutorlist = TutorList().tutorlist.toList();
  List<String> GetSpecial() {
    List<String> temp = [];
    for (var i = 0; i < tutorlist.length; ++i) {
      temp.add(tutorlist[i].skill);
    }
    temp.add("Show Favorite");
    return temp.toSet().toList();
  }

  late List<String> getSpecial = GetSpecial();
  List<Tutor> FavTutor() {
    List<Tutor> tempFav = [];
    for (var i = 0; i < tutorlist.length; ++i) {
      if (tutorlist[i].favorite == true) tempFav.add(tutorlist[i]);
    }
    return tempFav.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Upcoming lesson",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(convertedDateTime, style: TextStyle(color: Colors.white)),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/video");
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Enter lesson room",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(150))))),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                child: Text("Search",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: TextField(
            controller: searchCon,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Tutor's name or nationailty",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
            onChanged: searchTutor,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                child: Text("Filters",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              IconButton(
                  onPressed: () {
                    setState(() => tutorlist = resettutorlist);
                  },
                  icon: Icon(Icons.refresh))
            ],
          ),
        ),
        Container(
          height: 40,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: getSpecial.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildSpecial(getSpecial[index])),
        ),
        Container(
          margin: EdgeInsets.only(top: 25, bottom: 10, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                child: Text("Tutors",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: ListView.builder(
            itemCount: tutorlist.length,
            itemBuilder: (context, index) => tutorlist[index],
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  void searchTutor(String query) {
    final SearchByName = TutorList().tutorlist.where((tutor) {
      final tutorName = tutor.name.toLowerCase();
      final input = query.toLowerCase();
      return tutorName.contains(input);
    }).toList();
    final SearchByNation = TutorList().tutorlist.where((tutor) {
      final tutorNationality = tutor.nationality.toLowerCase();
      final input = query.toLowerCase();
      return tutorNationality.contains(input);
    }).toList();

    setState(() => tutorlist = SearchByName + SearchByNation);
  }

  Widget buildSpecial(String text) => Row(
        children: [
          SizedBox(
            width: 15,
          ),
          ActionChip(
            backgroundColor: Colors.lightBlue,
            label: Text(text),
            onPressed: () {
              if (text == "Show Favorite") {
                setState(() => tutorlist = FavTutor());
              } else {
                setState(() => tutorlist = resettutorlist);
                final SearchBySpecial = TutorList().tutorlist.where((tutor) {
                  final tutorSpecial = tutor.skill;
                  return tutorSpecial.contains(text);
                }).toList();
                setState(() => tutorlist = SearchBySpecial);
              }
            },
          ),
        ],
      );
}

// var tutorlistbeta = TutorList().tutorlist;
// var tutorlistbeta1 = [
//   Tutor(
//     name: "Kiryu Kazuma",
//     avatar: "assets/images/ava1.png",
//     quotes: "4th chairman of Tojo Clan",
//     rating: 4.0,
//     rating_count: 13,
//     language: "Japanese",
//     skill: "Dragon",
//   ),
//   Tutor(
//     name: "Joryu",
//     avatar: "assets/images/ava3.jpg",
//     quotes: "Daidoji Faction's Agent",
//     rating: 5.0,
//     rating_count: 3,
//     language: "Japanese",
//     skill: "Agent",
//   ),
//   Tutor(
//     name: "Kihei Hanawa",
//     avatar: "assets/images/ava4.png",
//     quotes: "Daidoji Faction's Agent",
//     rating: 4.6,
//     rating_count: 1,
//     language: "Japanese",
//     skill: "Agent",
//   ),
//   Tutor(
//     name: "Taiga Saejima",
//     avatar: "assets/images/ava5.png",
//     quotes: "Saejima Family Patriarch",
//     rating: 0,
//     rating_count: 18,
//     language: "Japanese",
//     skill: "18-counts",
//   ),
//   Tutor(
//     name: "Daigo Dojima",
//     avatar: "assets/images/ava6.png",
//     quotes: "6th chairman of Tojo Clan",
//     rating: 5,
//     rating_count: 30000,
//     language: "Japanese",
//     skill: "Charisma",
//   ),
//   Tutor(
//     name: "Ichiban Kasuga",
//     avatar: "assets/images/ava7.png",
//     quotes: "Hero - Former Arakawa Family Member",
//     rating: 2.3,
//     rating_count: 10,
//     language: "Japanese",
//     skill: "Hero",
//   ),
//   Tutor(
//     name: "Goro Majima",
//     avatar: "assets/images/ava2.jpg",
//     quotes: "Majima Family Patriarch",
//     rating: 3.1,
//     rating_count: 99,
//     language: "Japanese",
//     skill: "Mad Dog",
//   ),
// ];