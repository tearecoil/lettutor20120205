import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/tag.dart';
import 'package:lettutor20120205/components/tutor.dart';
import 'package:lettutor20120205/models/tutor/tutor_api.dart';
import 'package:lettutor20120205/service-api/tutor-services.dart';
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
  List<Tutor_api>? _tutors;
  final searchCon = TextEditingController();
  List<Tutor_api> listtutor = [];
  List<Tutor_api> resetlisttutor = [];
  List<Tutor> tutorlist = TutorList().tutorlist.toList();
  List<Tutor> resettutorlist = TutorList().tutorlist.toList();
  List<String> getSpecial = [
    "business english",
    "conversational english",
    "english for kids",
    "ielts",
    "starters",
    "movers",
    "flyers",
    "ket",
    "pet",
    "toefl",
    "toeic"
  ];
  List<Tutor> FavTutor() {
    List<Tutor> tempFav = [];
    for (var i = 0; i < tutorlist.length; ++i) {
      if (tutorlist[i].favorite == true) tempFav.add(tutorlist[i]);
    }
    return tempFav.toSet().toList();
  }

  @override
  void initState() {
    super.initState();
    getTutors();
  }

  void _handleNameChange(String value) {
    setState(() {
      listtutor = _tutors!
          .where((tutor) =>
              tutor.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void getTutors() async {
    await TutorService.getListTutorWithPagination(
        page: 1,
        perPage: 10,
        onSuccess: (tutors) {
          _tutors = tutors.toList();
          print(_tutors);
          setState(() {});
        },
        onError: (message) {});
    setState(() {
      listtutor = _tutors ?? [];
      resetlisttutor = _tutors ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return _tutors == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(convertedDateTime,
                        style: TextStyle(color: Colors.white)),
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
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    IconButton(
                        onPressed: () {
                          setState(() => listtutor = resetlisttutor);
                        },
                        icon: Icon(Icons.refresh))
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
                  onChanged: _handleNameChange,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: Row(
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
                          setState(() => listtutor = resetlisttutor);
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
                margin:
                    EdgeInsets.only(top: 25, bottom: 10, left: 15, right: 15),
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
                  itemCount: listtutor.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: CircleAvatar(
                                                radius: 45,
                                                backgroundImage: NetworkImage(
                                                    listtutor[index].avatar ??
                                                        "https://sandbox.api.lettutor.com/avatar/cb9e7deb-3382-48db-b07c-90acf52f541cavatar1686550060378.jpg"),
                                                onBackgroundImageError: (exception,
                                                        stackTrace) =>
                                                    const Icon(
                                                        Icons
                                                            .person_outline_rounded,
                                                        size: 62),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        listtutor[index].name ??
                                                            'NO NAME',
                                                        style: const TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        " (" +
                                                            (listtutor[index]
                                                                    .country ??
                                                                'DEFAULT') +
                                                            ")",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                    Text(
                                                      "Language: " +
                                                          (listtutor[index]
                                                                  .language ??
                                                              "DEFAULT"),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    RatingBar(
                                                      rating: listtutor[index]
                                                              .rating ??
                                                          0,
                                                    ),
                                                  ],
                                                ),
                                                TagChip(
                                                  specialties: listtutor[index]
                                                          .specialties
                                                          ?.split(',') ??
                                                      [],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // favorite = !favorite;
                                            // if (favorite == false) {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(
                                            //     SnackBar(
                                            //       content: Container(
                                            //         padding: EdgeInsets.all(16),
                                            //         height: 90,
                                            //         decoration: BoxDecoration(
                                            //           color: Colors.red,
                                            //           borderRadius: BorderRadius.all(
                                            //               Radius.circular(20)),
                                            //         ),
                                            //         child: Column(
                                            //           crossAxisAlignment:
                                            //               CrossAxisAlignment.start,
                                            //           children: [
                                            //             Text(
                                            //               "Remove from Favorite",
                                            //               style: TextStyle(
                                            //                 fontSize: 18,
                                            //                 color: Colors.white,
                                            //               ),
                                            //             ),
                                            //             Text(
                                            //               "You can recheck the list",
                                            //               style: TextStyle(
                                            //                 fontSize: 12,
                                            //                 color: Colors.white,
                                            //               ),
                                            //               maxLines: 2,
                                            //               overflow:
                                            //                   TextOverflow.ellipsis,
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //       behavior: SnackBarBehavior.floating,
                                            //       backgroundColor: Colors.transparent,
                                            //       elevation: 0,
                                            //     ),
                                            //   );
                                            // } else {
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(
                                            //     SnackBar(
                                            //       content: Container(
                                            //         padding: EdgeInsets.all(16),
                                            //         height: 90,
                                            //         decoration: BoxDecoration(
                                            //           color: Colors.green,
                                            //           borderRadius: BorderRadius.all(
                                            //               Radius.circular(20)),
                                            //         ),
                                            //         child: Column(
                                            //           crossAxisAlignment:
                                            //               CrossAxisAlignment.start,
                                            //           children: [
                                            //             Text(
                                            //               "Add to Favorite",
                                            //               style: TextStyle(
                                            //                 fontSize: 18,
                                            //                 color: Colors.white,
                                            //               ),
                                            //             ),
                                            //             Text(
                                            //               "You can recheck the list",
                                            //               style: TextStyle(
                                            //                 fontSize: 12,
                                            //                 color: Colors.white,
                                            //               ),
                                            //               maxLines: 2,
                                            //               overflow:
                                            //                   TextOverflow.ellipsis,
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //       behavior: SnackBarBehavior.floating,
                                            //       backgroundColor: Colors.transparent,
                                            //       elevation: 0,
                                            //     ),
                                            //   );
                                            // }
                                          },
                                          icon: Icon(Icons.favorite),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        listtutor[index].bio ?? "NO BIO YET",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ))),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ],
          );
  }

  List<String> buildSpecialties(String query) {
    List<String> temp = query.split(',');
    List<String> result = [];
    for (var i = 0; i < temp.length; ++i) {
      String str = temp[i];
      String add_string = '';
      for (var j = 0; j < str.length; ++j) {
        if (str[j] != '-')
          add_string = add_string + str[j];
        else
          add_string = add_string + ' ';
      }
      result.add(add_string);
    }
    print(result);
    return result;
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
                //print(text);
                setState(() => listtutor = resetlisttutor);
                final SearchBySpecial = listtutor.where((tutor) {
                  final tutorSpecial =
                      buildSpecialties(tutor.specialties ?? "");
                  return tutorSpecial.contains(text);
                }).toList();
                setState(() => listtutor = SearchBySpecial);
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
