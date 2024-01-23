import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/reviewUI.dart';
import 'package:lettutor20120205/components/review_list.dart';
import 'package:lettutor20120205/components/tutor.dart';
import 'package:lettutor20120205/utils/mechanic/diff_time.dart';
import 'package:lettutor20120205/models/tutor/tutor_info.dart';
import 'package:lettutor20120205/models/tutor/tutor_review.dart';
import 'package:lettutor20120205/service-api/tutor-services.dart';

class Reviews extends StatefulWidget {
  Reviews({
    Key? key,
    required this.userID,
  }) : super(key: key);
  final String userID;
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;
  List<ReviewTutor>? _feedbacks;
  TutorInfo? tutor;
  @override
  void initState() {
    super.initState();
    getTutorFeedbacks();
    getTutorInfo();
  }

  void getTutorFeedbacks() async {
    await TutorService.getTutorFeedback(
        page: 1,
        perPage: 10,
        userId: widget.userID,
        onSuccess: (feedbacks) {
          feedbacks.toList().sort((ReviewTutor late, ReviewTutor old) {
            return old.createdAt
                .toString()
                .compareTo(late.createdAt.toString());
          });

          setState(() {
            _feedbacks = feedbacks;
          });
        },
        onError: (message) {});
  }

  void getTutorInfo() async {
    await TutorService.getTutorInformation(
        tutorID: widget.userID,
        onSuccess: (tutorinfo) {
          tutor = tutorinfo;
          setState(() {});
        },
        onError: (message) {
          print(message);
        });
  }

  @override
  Widget build(BuildContext context) {
    return _feedbacks == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Reviews"),
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
            body: Column(
              children: [
                Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: tutor?.rating.toString(),
                                  style: TextStyle(fontSize: 48),
                                ),
                                TextSpan(
                                  text: "/5",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          RatingBar(
                            rating: tutor?.rating ?? 0,
                            ratingCount: _feedbacks?.length,
                            size: 25,
                          ),
                          Text(
                            "${_feedbacks?.length} reviews",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: tutor?.user?.avatar ?? '',
                            fit: BoxFit.cover,
                            width: 62,
                            height: 62,
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              size: 42,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(tutor?.user?.name ?? "NO NAME",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("Teacher"),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    itemCount: _feedbacks!.length,
                    itemBuilder: (context, index) {
                      return ReviewUI(
                        avatar: _feedbacks?[index].firstInfo?.avatar ?? "",
                        // avatar: ReviewGenList().reviewlist[index].avatar,
                        name: _feedbacks?[index].firstInfo?.name ?? "",
                        date: TimeDiff.timeAgo(
                            _feedbacks?[index].createdAt! ?? "Dec 26 2023"),
                        review: _feedbacks?[index].content ?? "",
                        rating: _feedbacks?[index].rating as double,
                        onpress: () => print("More Action $index"),
                        ontap: () => setState(() {
                          isMore = !isMore;
                        }),
                        isLess: isMore,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 2,
                      );
                    },
                  ),
                ),
                // Expanded(
                //   child: ListView.separated(
                //     padding: EdgeInsets.only(bottom: 8, top: 8),
                //     itemCount: ReviewGenList().reviewlist.length,
                //     itemBuilder: (context, index) {
                //       return ReviewUI(
                //         avatar: ReviewGenList().reviewlist[index].avatar,
                //         name: ReviewGenList().reviewlist[index].name,
                //         date: ReviewGenList().reviewlist[index].date,
                //         review: ReviewGenList().reviewlist[index].review,
                //         rating: ReviewGenList().reviewlist[index].rating,
                //         onpress: () => print("More Action $index"),
                //         ontap: () => setState(() {
                //           isMore = !isMore;
                //         }),
                //         isLess: isMore,
                //       );
                //     },
                //     separatorBuilder: (context, index) {
                //       return Divider(
                //         thickness: 2,
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          );
  }
}
