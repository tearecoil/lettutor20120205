import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/my_button.dart';
import 'package:lettutor20120205/components/my_profile_box.dart';
import 'package:lettutor20120205/components/profile_box.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/tutor.dart';
import 'package:lettutor20120205/service-api/user-services.dart';
import 'package:lettutor20120205/tutor_pages/reviews.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lettutor20120205/models/user/User.dart';

class MyStudentProfile extends StatefulWidget {
  const MyStudentProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<MyStudentProfile> createState() => _MyStudentProfileState();
}

class _MyStudentProfileState extends State<MyStudentProfile> {
  String? name;
  String? email;
  String? avatar_link;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  String? role;
  String? bio;
  String? level;
  List<String> CurrentLevel = [
    "BEGINNER",
    "HIGHER_BEGINNER",
    "PRE_INTERMEDIATE",
    "INTERMEDIATE",
    "UPPER_INTERMEDIATE",
    "ADVANCED",
    "PROFICIENCY",
  ];
  late String chosen;
  @override
  void initState() {
    super.initState();
    loadInfo();
    chosen = level ?? "BEGINNER";
  }

  void loadInfo() async {
    name = UserLogged.name;
    email = UserLogged.email;
    avatar_link = UserLogged.avatar;
    country = UserLogged.country;
    phone = UserLogged.phone;
    roles = UserLogged.roles;
    language = UserLogged.language;
    birthday = UserLogged.birthday;
    bio = UserLogged.requireNote;
    level = UserLogged.level;
    role = roles?.first;
  }

  Future<void> setLevel(String field) async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Choose your current level'),
              content: DropdownButton<String>(
                value: chosen,
                onChanged: (value) {
                  setState(() {
                    chosen = value.toString();
                  });
                },
                items: CurrentLevel.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      UserService.updateInfo(
                        updateUser: User(
                          name: name,
                          requireNote: bio,
                          birthday: birthday,
                          language: language,
                          level: chosen,
                          avatar: avatar_link,
                        ),
                        onSuccess: (user) {
                          UserLogged = user ?? UserLogged;
                          Navigator.popAndPushNamed(context, "/studentprofile");
                        },
                        onError: (message) {
                          print(message);
                        },
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text("Submit"))
              ],
            );
          });
        });
  }

  Future<void> setField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new value",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
    if (newValue.trim().length > 0) {
      SharedPreferences sharedpref = await SharedPreferences.getInstance();
      // Navigator.popAndPushNamed(context, "/studentprofile");
      // sharedpref.setString(field, newValue);
      if (field == 'name') {
        name = newValue;
      } else if (field == 'aboutMe') {
        bio = newValue;
      } else if (field == 'birthday') {
        birthday = newValue;
      } else if (field == 'language') {
        language = newValue;
      } else if (field == 'country') {
        country = newValue;
      } else {
        level = newValue;
      }
    }

    await UserService.updateInfo(
      updateUser: User(
        name: name,
        requireNote: bio,
        birthday: birthday,
        language: language,
        level: level,
        avatar: avatar_link,
        country: country,
      ),
      onSuccess: (user) {
        UserLogged = user ?? UserLogged;
        Navigator.popAndPushNamed(context, "/studentprofile");
      },
      onError: (message) {
        print(message);
      },
    );
  }

  Future<void> setTutor() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString('accountType', "/teacherprofile");
    Navigator.popAndPushNamed(context, "/teacherprofile");
  }

  Future<void> pressLogOut() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.clear();
    Navigator.popAndPushNamed(context, "/login");
  }

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
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text("Log Out"),
                              )
                            ],
                          ),
                          onTap: () {
                            pressLogOut();
                            // Navigator.popAndPushNamed(context, "/login");
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    //margin: EdgeInsets.only(right: 16),
                    child: Image.network(avatar_link ?? ""),
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(avatar ?? ""),
                    //     fit: BoxFit.cover,
                    //   ),
                    //   borderRadius: BorderRadius.circular(100),
                    // ),
                  ),
                ],
              ),
              Text(
                name ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                email ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                role ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      child: Text(
                        country ?? "COUNTRY NOT DEFINED, CLICK TO EDIT",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          decoration: TextDecoration.underline,
                          decorationThickness: 0.2,
                        ),
                      ),
                      onTap: () => setField('country')),
                ],
              ),
              // Text(
              //   country ?? "",
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 50),
              MyProfileBox(
                  text: name ?? "Default Name",
                  sectionName: "My Name",
                  onpress: () => setField('name')),
              SizedBox(height: 5),
              MyProfileBox(
                  text: bio ?? "Null",
                  sectionName: "About me",
                  onpress: () => setField('aboutMe')),
              SizedBox(height: 5),
              MyProfileBox(
                  text: birthday ?? "Null",
                  sectionName: "Birthday",
                  onpress: () => setField('birthday')),
              SizedBox(height: 5),
              MyProfileBox(
                  text: language ?? "Null",
                  sectionName: "Language",
                  onpress: () => setField('language')),
              SizedBox(height: 5),
              MyProfileBox(
                  text: level ?? "BEGINNER",
                  sectionName: "Level",
                  onpress: () => setLevel('level')),
              SizedBox(height: 25),
              MyButton(
                text: "Become a Tutor",
                onTap: () {
                  setTutor();
                },
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Container(
              //       margin: const EdgeInsets.only(bottom: 6, top: 10),
              //       child: const Text(
              //         "Courses",
              //         style: TextStyle(fontSize: 17, color: Colors.blue),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 220,
              //       child: ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: CourseList().Course_List.length,
              //           itemBuilder: (context, index) =>
              //               CourseList().Course_List[index]),
              //     ),
              //   ],
              // ),
            ],
          ),
        ));
  }
}
