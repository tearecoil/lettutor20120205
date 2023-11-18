import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/rating_bar.dart';
import 'package:lettutor20120205/components/reviewUI.dart';
import 'package:lettutor20120205/components/review_list.dart';
import 'package:lettutor20120205/components/tutor.dart';

class Reviews extends StatefulWidget {
  Reviews({
    Key? key,
    required this.tutor,
  }) : super(key: key);
  final Tutor tutor;
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            text: widget.tutor.rating.toString(),
                            style: TextStyle(fontSize: 48),
                          ),
                          TextSpan(
                            text: "/5",
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    RatingBar(
                      rating: widget.tutor.rating,
                      size: 25,
                    ),
                    Text(
                      "${ReviewGenList().reviewlist.length} reviews",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      widget.tutor.avatar,
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 10),
                    Text(widget.tutor.name,
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
              itemCount: ReviewGenList().reviewlist.length,
              itemBuilder: (context, index) {
                return ReviewUI(
                  avatar: ReviewGenList().reviewlist[index].avatar,
                  name: ReviewGenList().reviewlist[index].name,
                  date: ReviewGenList().reviewlist[index].date,
                  review: ReviewGenList().reviewlist[index].review,
                  rating: ReviewGenList().reviewlist[index].rating,
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
        ],
      ),
    );
  }
}
