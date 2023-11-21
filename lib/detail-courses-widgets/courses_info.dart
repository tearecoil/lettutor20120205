import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/chapter_card.dart';
import 'package:lettutor20120205/components/event_add.dart';
import 'package:lettutor20120205/components/course_card.dart';
import 'package:lettutor20120205/detail-courses-widgets/chapter_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CourseOverview extends StatefulWidget {
  const CourseOverview({
    Key? key,
    required this.courseinput,
  });
  final CourseCard courseinput;
  @override
  State<CourseOverview> createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverview> {
  bool? couFlag;
  @override
  void initState() {
    super.initState();
    checkCourseState();
  }

  void checkCourseState() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    List<String>? flag = sharedpref.getStringList('schedule') ?? [];
    if (flag[widget.courseinput.index] == "False") {
      couFlag = false;
      print("$couFlag");
    } else {
      couFlag = true;
      print("$couFlag");
    }
  }

  Future<void> setCourseState() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    List<String>? flag = sharedpref.getStringList('schedule') ?? [];
    if (flag[widget.courseinput.index] == "False") {
      flag[widget.courseinput.index] = "True";
      sharedpref.setStringList('schedule', flag);
      print("$couFlag");
    } else {
      flag[widget.courseinput.index] = "False";
      sharedpref.setStringList('schedule', flag);
      print("$couFlag");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.courseinput.source),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    widget.courseinput.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Text(
                                    "Written in 2023",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 50,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.question_mark,
                            color: Colors.red,
                          ),
                          Text(
                            "Overview",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.courseinput.overview,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.red,
                          ),
                          Text(
                            "Duration",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.courseinput.hours.toString() + " hours",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.book,
                            color: Colors.red,
                          ),
                          Text(
                            "Chapters List",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.courseinput.lesson,
                itemBuilder: (context, index) => ChapterCard(
                  name: widget.courseinput.chapter[index],
                  tag: widget.courseinput.tag[index],
                  chapterNumber: index + 1,
                  backgroundava: widget.courseinput.source,
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ChapterPage(
                            chapterinput: ChapterCard(
                                name: widget.courseinput.chapter[index],
                                tag: widget.courseinput.tag[index],
                                chapterNumber: index,
                                backgroundava: widget.courseinput.source,
                                onTap: () {})),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                          Text(
                            "Experience Level",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.courseinput.level,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.pending_actions_outlined,
                            color: Colors.red,
                          ),
                          Text(
                            "Next Course",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                // if (couFlag == false) {
                                //   setCourseState();
                                //   // Meeting temp = Meeting(
                                //   //     widget.courseinput.title,
                                //   //     widget.courseinput.nextCourse,
                                //   //     widget.courseinput.nextCourse.add(
                                //   //         Duration(
                                //   //             hours: widget.courseinput.hours)),
                                //   //     widget.courseinput.hours);
                                //   // ListMeeting().listmeet.add(temp);
                                // } else {}
                                setCourseState();
                                setState(() {
                                  if (couFlag == false) {
                                    couFlag = true;
                                  } else {
                                    couFlag = false;
                                  }
                                  ListMeeting().listmeet.removeWhere((temp) =>
                                      temp.eventName ==
                                      widget.courseinput.title);
                                });
                              },
                              child: couFlag ?? false
                                  ? Text("Remove")
                                  : Text("Add"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: couFlag ?? false
                                    ? Colors.red
                                    : Colors.green,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${widget.courseinput.nextCourse.year}-${widget.courseinput.nextCourse.month}-${widget.courseinput.nextCourse.day}  ${widget.courseinput.nextCourse.hour}:${widget.courseinput.nextCourse.minute}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color coloronpress) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return coloronpress;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }
}
