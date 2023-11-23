import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lettutor20120205/homescreens-widgets/course_page.dart';
import 'package:lettutor20120205/homescreens-widgets/my_courses_page.dart';
import 'package:lettutor20120205/homescreens-widgets/schedule_page.dart';
import 'package:lettutor20120205/homescreens-widgets/tutor_homepage.dart';
import 'package:lettutor20120205/homescreens-widgets/history_page.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<String> items = [
    "TUTOR",
    "SCHEDULE",
    "HISTORY",
    "COURSES",
    "MY COURSE",
  ];

  /// List of body icon
  List<IconData> icons = [
    Icons.person_rounded,
    Icons.calendar_today,
    Icons.lock_clock,
    Icons.palette,
    Icons.palette_outlined,
  ];

  List<dynamic> screens = [
    TutorHomePage(),
    SchedulePage(),
    HistoryPage(),
    CoursePage(),
    MyCoursesPage(),
  ];

  int current = 0;
  PageController pageController = PageController();
  Future<void> leadtoProfile() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String getLink = sharedpref.getString('accountType') ?? "123";
    Navigator.pushNamed(context, getLink);
  }

  @override
  void initState() {
    super.initState();
    setCourse();
  }

  void setCourse() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    List<String> temp = [];
    for (var course in CourseList().Course_List) {
      temp.add("False");
    }
    sharedpref.setStringList('schedule', temp);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('LETTUTOR', style: TextStyle(color: Colors.blue)),
            centerTitle: true,
            actions: <Widget>[
              Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/my_ava.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: GestureDetector(onTap: () => leadtoProfile()),
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, "/profile");
              //   },
              //   icon: Image.asset(
              //     'assets/images/my_ava.jpg',
              //     width: 100,
              //     height: 100,
              //   ),
              // ),
            ],
            backgroundColor: Colors.white,
            leading: Container(
              width: 25,
              height: 25,
              child: Image.asset(
                'assets/images/logo-ltt.png',
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                /// Tab Bar
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                                pageController.animateToPage(
                                  current,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.ease,
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.all(5),
                                width: 100,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: current == index
                                      ? Colors.white70
                                      : Colors.white54,
                                  borderRadius: current == index
                                      ? BorderRadius.circular(12)
                                      : BorderRadius.circular(7),
                                  border: current == index
                                      ? Border.all(
                                          color: Colors.blue, width: 2.5)
                                      : null,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        icons[index],
                                        size: current == index ? 23 : 20,
                                        color: current == index
                                            ? Colors.black
                                            : Colors.grey.shade400,
                                      ),
                                      Text(
                                        items[index],
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: current == index,
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    shape: BoxShape.circle),
                              ),
                            )
                          ],
                        );
                      }),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: icons.length,
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (index == 0) return screens[current];
                      // else
                      //   return screens[index];
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
