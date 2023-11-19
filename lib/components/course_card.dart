import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/chapter_card.dart';
import 'package:lettutor20120205/detail-courses-widgets/courses_info.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String source;
  final String level;
  final int lesson;
  final String overview;
  final List<String> chapter;
  final List<String> tag;

  CourseCard({
    required this.title,
    required this.source,
    required this.level,
    required this.lesson,
    required this.overview,
    required this.chapter,
    required this.tag,
  });
// class CourseCard extends StatelessWidget {
//   // const CourseCard({
//   //   Key? key,
//   //   required String title,
//   //   required String source,
//   //   required String level,
//   //   required int lesson,
//   //   required String overview,
//   //   required List<String> chapter,
//   // })  : _title = title,
//   //       _source = source,
//   //       _lesson = lesson,
//   //       _level = level,
//   //       _overview = overview,
//   //       _chapter = chapter,
//   //       super(key: key);

//   final String _title, _source, _level, _overview;
//   final int _lesson;
//   final List<String> _chapter;

//   CourseCard(required String title,
//     required String source,
//     required String level,
//     required int lesson,
//     required String overview,
//     required List<String> chapter,);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => CourseOverview(
                courseinput: CourseCard(
              title: this.title,
              source: this.source,
              lesson: this.lesson,
              level: this.level,
              overview: this.overview,
              chapter: this.chapter,
              tag: this.tag,
            )),
          ),
        );
      },
      child: Card(
        elevation: 8,
        child: SizedBox(
          width: 200,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                source,
                height: 130,
                width: 130,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            level,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[800]),
                          ),
                          Text(
                            "$lesson Lessons",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[800]),
                          ),
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
