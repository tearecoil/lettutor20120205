import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.specialties});

  final List<String?> specialties;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 6,
      runSpacing: 8,
      children: List<Widget>.generate(
        specialties.length,
        (index) => Chip(
          side: const BorderSide(width: 0, color: Colors.transparent),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.lightBlue,
          label: Text(
            specialties[index]!.replaceAll(RegExp(r'-'), ' ') ?? "",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ).toList(),
    );
  }
}
