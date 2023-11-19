import 'package:flutter/material.dart';

class ProfileBox extends StatelessWidget {
  final String text;
  final String sectionName;
  const ProfileBox({
    super.key,
    required this.text,
    required this.sectionName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.settings,
              //     color: Colors.grey[400],
              //   ),
              // ),
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
