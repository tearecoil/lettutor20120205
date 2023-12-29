import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/chapter_card.dart';
import 'package:lettutor20120205/detail-courses-widgets/courses_info.dart';
import 'package:lettutor20120205/models/course/course.dart';
import 'package:lettutor20120205/models/e-book/e-book.dart';
import 'package:url_launcher/url_launcher.dart';

class EBookCard extends StatelessWidget {
  final EBook course;
  EBookCard({
    required this.course,
  });

  final coursesLevel = {
    '0': 'Any Level',
    '1': 'Beginner',
    '2': 'Upper-Beginner',
    '3': 'Pre-Intermediate',
    '4': 'Intermediate',
    '5': 'Upper-Intermediate',
    '6': 'Pre-Advanced',
    '7': 'Advanced',
    '8': 'Very Advanced',
  };
  String getLevel(String level) {
    return coursesLevel[level] ?? "";
  }

  void _launchEBookUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchEBookUrl(course.fileUrl ?? 'null url');
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        child: Card(
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: course.imageUrl ?? '',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(
                  Icons.error_outline_rounded,
                  size: 32,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Column(
                  children: [
                    Text(
                      course.name ?? "no name",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Level: " + (getLevel(course.level ?? "")),
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),
                    ),
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
