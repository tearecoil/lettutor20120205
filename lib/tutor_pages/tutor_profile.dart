import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/profile_box.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/tutor.dart';
import 'package:lettutor20120205/tutor_pages/reviews.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.tutor.avatar),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
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
              Text(
                widget.tutor.nationality.toString(),
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
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => Reviews(
                                tutor: Tutor(
                              name: widget.tutor.name,
                              avatar: widget.tutor.avatar,
                              quotes: widget.tutor.quotes,
                              education: widget.tutor.education,
                              rating: widget.tutor.rating,
                              rating_count: widget.tutor.rating_count,
                              language: widget.tutor.language,
                              skill: widget.tutor.skill,
                              nationality: widget.tutor.nationality,
                              favorite: widget.tutor.favorite,
                            )),
                          ),
                        );
                      },
                      icon: Icon(Icons.star),
                      label: const Text('Reviews')),
                ],
              ),
              const SizedBox(height: 50),
              ProfileBox(text: widget.tutor.quotes, sectionName: "About me"),
              SizedBox(height: 5),
              ProfileBox(
                  text: widget.tutor.education, sectionName: "Education"),
              SizedBox(height: 5),
              ProfileBox(text: widget.tutor.language, sectionName: "Language"),
              SizedBox(height: 5),
              ProfileBox(text: widget.tutor.skill, sectionName: "Skill"),
              SizedBox(height: 5),
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
            ],
          ),
        ));
  }
}
