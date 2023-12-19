import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/profile_box.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/tag.dart';
import 'package:lettutor20120205/components/tutor.dart';
import 'package:lettutor20120205/models/tutor/tutor_api.dart';
import 'package:lettutor20120205/models/tutor/tutor_info.dart';
import 'package:lettutor20120205/service-api/tutor-services.dart';
import 'package:lettutor20120205/tutor_pages/reviews.dart';
import 'package:video_player/video_player.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  TutorInfo? tutor;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    getTutorInfo();
    setState(() {});
  }

  void getTutorInfo() async {
    await TutorService.getTutorInformation(
        tutorID: widget.id,
        onSuccess: (tutorinfo) {
          print("OK");
          tutor = tutorinfo;
          _videoPlayerController =
              VideoPlayerController.network(tutorinfo.video ?? '');
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            aspectRatio: 2 / 3,
            autoPlay: true,
          );
          setState(() {});
        },
        onError: (message) {
          print(message);
        });
    // setState(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
    String name = tutor?.user?.name ?? "NO NAME";

    return tutor == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
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
                        margin: EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(tutor?.user?.avatar ??
                              "https://sandbox.api.lettutor.com/avatar/cb9e7deb-3382-48db-b07c-90acf52f541cavatar1686550060378.jpg"),
                          onBackgroundImageError: (exception, stackTrace) =>
                              const Icon(Icons.person_outline_rounded,
                                  size: 62),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar(
                        rating: tutor?.rating ?? 0,
                        ratingCount: tutor?.totalFeedback,
                      ),
                    ],
                  ),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    "Teacher",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text(
                    tutor?.user?.country ?? "DEFAULT COUNTRY",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Added to Favorite!!",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "You can check your Favorite list",
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
                          icon: Icon(Icons.thumb_up),
                          label: Text("Favorite")),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            // Navigator.push<void>(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) => Reviews(
                            //         tutor: Tutor(
                            //       name: tutor?.name,
                            //       avatar: tutor?.avatar,
                            //       quotes: tutor?.quotes,
                            //       education: tutor?.education,
                            //       rating: tutor?.rating,
                            //       rating_count: tutor?.rating_count,
                            //       language: tutor?.language,
                            //       skill: tutor?.skill,
                            //       nationality: tutor?.nationality,
                            //       favorite: tutor?.favorite,
                            //     )),
                            //   ),
                            // );
                          },
                          icon: Icon(Icons.star),
                          label: const Text('Reviews')),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "VIDEO",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: _chewieController == null
                        ? Text(
                            'Loading...',
                          )
                        : Chewie(controller: _chewieController!),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "MY INFORMATION",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  ProfileBox(
                      text: tutor?.bio ?? "NOTHING", sectionName: "About me"),
                  SizedBox(height: 5),
                  ProfileBox(
                      text: tutor?.interests ?? "NOTHING",
                      sectionName: "Interests"),
                  SizedBox(height: 5),
                  ProfileBox(
                      text: tutor?.education ?? "NOTHING",
                      sectionName: "Education"),
                  SizedBox(height: 5),
                  ProfileBox(
                      text: tutor?.profession ?? "NOTHING",
                      sectionName: "Profession"),
                  SizedBox(height: 5),
                  ProfileBox(
                      text: tutor?.languages ?? "NOTHING",
                      sectionName: "Skill"),
                  SizedBox(height: 5),
                  Text(
                    "     Specialties",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      TagChip(
                        specialties: tutor?.specialties?.split(',') ?? [],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 6, top: 10),
                        child: const Text(
                          "COURSES",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
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