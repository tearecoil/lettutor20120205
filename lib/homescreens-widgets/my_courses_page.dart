import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_list.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Image.asset(
          "assets/images/my_ava.jpg",
          width: 100,
          height: 100,
        ),
        const Text(
          "Username",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const Text(
          "Student",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 10),
        ),
        const Text(
          "VietNam",
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
