import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  int? ratingCount;

  RatingBar({required this.rating, this.ratingCount, this.size = 18});

  @override
  Widget build(BuildContext context) {
    List<Widget> _starlist = [];
    String count = ratingCount.toString();
    int realNum = rating.floor();
    int partNum = ((rating - realNum) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNum) {
        _starlist.add(Icon(
          Icons.star,
          color: Theme.of(context).primaryColor,
          size: size,
        ));
      } else if (i == realNum) {
        _starlist.add(
          SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                  size: size,
                ),
                ClipRect(
                  clipper: _clipper(part: partNum),
                  child: Icon(
                    Icons.star,
                    color: Colors.grey,
                    size: size,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        _starlist.add(Icon(Icons.star, color: Colors.grey, size: size));
      }
    }
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: _starlist,
        ),
        Text(
          " (" + count + ")",
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}

class _clipper extends CustomClipper<Rect> {
  final int part;
  _clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB((size.width / 10) * part, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
