import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/rating_bar.dart';

class ReviewUI extends StatelessWidget {
  final String avatar;
  final String name;
  final String date;
  final String review;
  final double rating;
  final Function() ontap;
  final Function() onpress;
  final bool isLess;
  final int ratingCount = 1;
  const ReviewUI({
    Key? key,
    required this.avatar,
    required this.name,
    required this.date,
    required this.review,
    required this.rating,
    required this.ontap,
    required this.onpress,
    required this.isLess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2,
        bottom: 2,
        left: 16,
        right: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(avatar),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(onPressed: onpress, icon: Icon(Icons.more_vert)),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              RatingBar(rating: rating),
              SizedBox(width: 5),
              Text(
                date,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: ontap,
            child: isLess
                ? Text(
                    review,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                : Text(
                    review,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
