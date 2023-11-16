import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/profile_box.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/tutor.dart';

class TutorProfile extends StatefulWidget {
  const TutorProfile({
    Key? key,
    required this.tutor,
  }) : super(key: key);

  final Tutor tutor;
  @override
  State<TutorProfile> createState() => _TutorProfileState();
}

class _TutorProfileState extends State<TutorProfile> {
  @override
  Widget build(BuildContext context) {
    String name = widget.tutor.name;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Image.asset(
                widget.tutor.avatar,
                width: 100,
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar(rating: widget.tutor.rating),
                  Text(
                    " (" + widget.tutor.rating_count.toString() + ")",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                widget.tutor.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text(
                "Teacher",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              const Text(
                "Japan",
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Added to Favorite",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "You can check your Favorite list now",
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
                      },
                      icon: Icon(Icons.thumb_up_sharp),
                      label: Text("Favorite")),
                  TextButton.icon(
                      onPressed: () {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reported!!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Admin will check this account",
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
                      },
                      icon: Icon(Icons.heart_broken),
                      label: Text("Report")),
                  TextButton.icon(
                      onPressed: () {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Review",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Todo",
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
                      },
                      icon: Icon(Icons.star),
                      label: const Text('Reviews')),
                ],
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "About me",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ProfileBox(text: widget.tutor.quotes),
              //const Text("Hello, I'm Ash Ketchup"),
              //const SizedBox(height: 50),
              const Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Education",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const ProfileBox(text: "I'm a master in PokemonGo"),
              //const Text("I'm a master in PokemonGo"),
              const Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Experience",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const ProfileBox(text: "Two time finalist of Pokemon Tournament"),
              //const Text("Two time finalist of Pokemon Tournament"),
              const Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Interests",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const ProfileBox(text: "Training Pokemon"),
              //const Text("Training Pokemon"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 6, top: 10),
                    child: const Text(
                      "Courses",
                      style: TextStyle(fontSize: 17, color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: CourseList().Course_List.length,
                        itemBuilder: (context, index) =>
                            CourseList().Course_List[index]),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
