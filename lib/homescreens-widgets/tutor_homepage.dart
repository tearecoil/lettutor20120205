import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/tag.dart';
import 'package:lettutor20120205/components/tutor.dart';
import 'package:lettutor20120205/homescreens-widgets/call_header.dart';
import 'package:lettutor20120205/models/course-topic/speciality.dart';
import 'package:lettutor20120205/models/course-topic/speciality.dart';
import 'package:lettutor20120205/models/course-topic/speciality.dart';
import 'package:lettutor20120205/models/data/data_service.dart';
import 'package:lettutor20120205/models/tutor/tutor_api.dart';
import 'package:lettutor20120205/models/tutor/tutor_info.dart';
import 'package:lettutor20120205/service-api/tutor-services.dart';
import 'package:lettutor20120205/tutor_pages/view_tutor_profile.dart';
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
  List<Speciality>? getSpeciality;
  final searchCon = TextEditingController();
  List<Tutor_api> listtutor = [];
  List<Tutor_api> resetlisttutor = [];
  List<Tutor> tutorlist = TutorList().tutorlist.toList();
  List<Tutor> resettutorlist = TutorList().tutorlist.toList();
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

  void searchbyName(String value) async {
    await TutorService.getTutorwithFilters(
        page: 1,
        perPage: 10,
        search: value,
        onSuccess: (tutors) {
          _tutors = tutors.toList();
          setState(() {});
        },
        onError: (message) {});
  }

  void getTutors() async {
    await TutorService.getTutorwithFilters(
        page: 1,
        perPage: 10,
        onSuccess: (tutors) {
          _tutors = tutors.toList();
          setState(() {});
        },
        onError: (message) {});
    setState(() {
      listtutor = _tutors ?? [];
      resetlisttutor = _tutors ?? [];
    });

    await DataService.getTestPreparation(
        onSuccess: (testPreparations) async {
          await DataService.getTopic(
              onSuccess: (topics) {
                getSpeciality = [...testPreparations, ...topics];
              },
              onError: (message) {});
        },
        onError: (message) {});

    // print('Speciality');
    // print(getSpeciality?[0].name!);
    setState(() {});
  }

  bool checkFavorite(String userId, int index) {
    if (_tutors?[index].isFavoriteTutor == true) {
      return true;
    } else {
      return false;
    }
  }

  void addFavorite(String userId, int index) async {
    await TutorService.addFavorite(
      userId: userId,
      onSuccess: () {
        setState(() {
          _tutors![index].isFavoriteTutor =
              !(_tutors![index].isFavoriteTutor ?? false);
        });
      },
      onError: (message) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return _tutors == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // Container(
              //   height: 200,
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.blue,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "LetTutor Video Lesson",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold, color: Colors.white),
              //       ),
              //       Text(
              //           "Press below button to join call, course information would be shown",
              //           style: TextStyle(color: Colors.white)),
              //       Container(
              //         margin: EdgeInsets.only(top: 10),
              //         child: ElevatedButton(
              //             onPressed: () {
              //               Navigator.pushNamed(context, "/video");
              //             },
              //             child: Container(
              //               padding: EdgeInsets.only(top: 10, bottom: 10),
              //               child: Text(
              //                 "Enter lesson room",
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //             style: ElevatedButton.styleFrom(
              //                 primary: Colors.white,
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(150))))),
              //       ),
              //     ],
              //   ),
              // ),
              HomeHeader(),
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
                  onChanged: searchbyName,
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
                          getTutors();
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              Container(
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getSpeciality?.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildSpecial(getSpeciality![index])),
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
                  itemCount: _tutors?.length,
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
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ViewProfile(
                                      id: _tutors?[index].userId ??
                                          "4d54d3d7-d2a9-42e5-97a2-5ed38af5789a",
                                    ),
                                  ),
                                );
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
                                                    _tutors?[index].avatar ??
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
                                                        _tutors?[index].name ??
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
                                                            (_tutors?[index]
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
                                                          (_tutors?[index]
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
                                                      rating: _tutors?[index]
                                                              .rating ??
                                                          0,
                                                    ),
                                                  ],
                                                ),
                                                TagChip(
                                                  specialties: _tutors?[index]
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
                                            addFavorite(
                                                _tutors?[index].userId ?? '',
                                                index);
                                            !checkFavorite(
                                                    _tutors?[index].userId ??
                                                        '',
                                                    index)
                                                ? ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                    SnackBar(
                                                      duration:
                                                          Duration(seconds: 2),
                                                      content: Container(
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Added to Favorite",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Reload this page to view your favorite list",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                  )
                                                : ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                    SnackBar(
                                                      duration:
                                                          Duration(seconds: 2),
                                                      content: Container(
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Removed to Favorite",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Reload this page to view your favorite list",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                  );
                                          },
                                          icon: Icon(checkFavorite(
                                                  _tutors?[index].userId ?? '',
                                                  index)
                                              ? Icons.favorite
                                              : Icons.favorite_border),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        _tutors?[index].bio ?? "NO BIO YET",
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
    // print(result);
    return result;
  }

  Widget buildSpecial(Speciality? special) => Row(
        children: [
          SizedBox(
            width: 15,
          ),
          ActionChip(
            backgroundColor: Colors.lightBlue,
            label: Text(special?.name ?? ""),
            onPressed: () async {
              await TutorService.getTutorwithFilters(
                  page: 1,
                  perPage: 10,
                  specialties: [special?.key ?? ""],
                  onSuccess: (tutors) {
                    _tutors = tutors.toList();
                    setState(() {});
                  },
                  onError: (message) {});
            },
          ),
        ],
      );
}
