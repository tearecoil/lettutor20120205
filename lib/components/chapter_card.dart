import 'package:flutter/material.dart';
import 'package:lettutor20120205/models/course/course.dart';
import 'package:lettutor20120205/models/course/course_topic.dart';

class ChapterCard extends StatelessWidget {
  final Function()? onTap;
  final CourseTopic topic;
  final Course course;
  final int index;
  const ChapterCard({
    super.key,
    required this.onTap,
    required this.topic,
    required this.course,
    required this.index,
  });
  int getChapter(int value) {
    return value + 1;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        child: SizedBox(
          width: 200,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: [
                    Text(
                      // "Chapter ${getChapter(topic.orderCourse ?? 0)} : \n",
                      "Chapter ${index + 1}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      topic.name ?? '',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              topic.description ?? '',
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[800]),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
