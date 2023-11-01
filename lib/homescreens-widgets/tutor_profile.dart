import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_card.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/my_button.dart';
import 'package:lettutor20120205/components/profile_box.dart';

class TutorProfile extends StatefulWidget {
  const TutorProfile({super.key});

  @override
  State<TutorProfile> createState() => _TutorProfileState();
}

class _TutorProfileState extends State<TutorProfile> {
  @override
  Widget build(BuildContext context) {
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
                "assets/images/ava.png",
                width: 100,
                height: 100,
              ),
              Image.asset(
                "assets/images/newrate.png",
                width: 50,
                height: 50,
              ),
              const Text(
                "Teacher K",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text(
                "Teacher",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              const Text(
                "VietNam",
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.thumb_up_sharp),
                      label: Text("Favorite")),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.heart_broken),
                      label: Text("Report")),
                  TextButton.icon(
                      onPressed: () {},
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
              const ProfileBox(text: "Hello, I'm Ash Ketchup"),
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
