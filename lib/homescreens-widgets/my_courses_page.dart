import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  String? name;
  String? bio;
  String? avatar;
  String? accountType;
  String? username;
  String? nation;
  @override
  void initState() {
    super.initState();
    loadUsername();
    loadName();
    loadAboutMe();
    loadAvatar();
    loadNation();
    loadAccType();
  }

  void loadUsername() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    setState(() {
      username = sharedpref.getString('username') ?? "Insert name here";
    });
  }

  void loadName() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    setState(() {
      name = sharedpref.getString('name') ?? "Insert name here";
    });
  }

  void loadAboutMe() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    setState(() {
      bio = sharedpref.getString('aboutMe') ?? "Insert bio here";
    });
  }

  void loadAvatar() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    setState(() {
      avatar = sharedpref.getString('avatar') ?? "";
    });
  }

  void loadNation() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    setState(() {
      nation = sharedpref.getString('nation') ?? "";
    });
  }

  void loadAccType() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    setState(() {
      //sharedpref.setString('accountType', "/studentprofile");
      accountType = sharedpref.getString('accountType') ?? "";
      if (accountType == "/studentprofile") {
        accountType = "Student";
      } else {
        accountType = "Teacher";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Image.asset(
          avatar ?? "",
          width: 100,
          height: 100,
        ),
        Text(
          username ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          accountType ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 10),
        ),
        Text(
          nation ?? "",
          textAlign: TextAlign.center,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 6, top: 10),
              child: const Text(
                "My courses",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
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
    );
  }
}
