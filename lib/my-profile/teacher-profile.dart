import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/my_button.dart';
import 'package:lettutor20120205/components/my_profile_box.dart';
import 'package:lettutor20120205/components/profile_box.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/tutor.dart';
import 'package:lettutor20120205/tutor_pages/reviews.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTutorProfile extends StatefulWidget {
  const MyTutorProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<MyTutorProfile> createState() => _MyTutorProfileState();
}

class _MyTutorProfileState extends State<MyTutorProfile> {
  String? name;
  String? bio;
  String? avatar;
  String? nation;
  String? username;
  @override
  void initState() {
    super.initState();
    loadUsername();
    loadName();
    loadAboutMe();
    loadAvatar();
    loadNation();
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

  Future<void> setField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit name",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new name",
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
      Navigator.popAndPushNamed(context, "/studentprofile");
      sharedpref.setString(field, newValue);
      if (field == 'name') {
        loadName();
      } else if (field == 'aboutMe') {
        loadAboutMe();
      } else if (field == 'avatar') {
        loadAvatar();
      } else {
        loadNation();
      }
    }
  }

  Future<void> setStudent() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString('accountType', "/studentprofile");
    Navigator.popAndPushNamed(context, "/studentprofile");
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
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    //margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(avatar ?? ""),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
              Text(
                username ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Text(
                "Teacher",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                nation ?? "",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              MyProfileBox(
                  text: name ?? "Default Name",
                  sectionName: "My Name",
                  onpress: () => setField('name')),
              SizedBox(height: 5),
              MyProfileBox(
                  text: bio ?? "Default Bio",
                  sectionName: "About me",
                  onpress: () => setField('aboutMe')),
              SizedBox(height: 25),
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
              SizedBox(height: 25),
              MyButton(
                text: "Become a Student",
                onTap: () {
                  setStudent();
                },
              ),
            ],
          ),
        ));
  }
}
