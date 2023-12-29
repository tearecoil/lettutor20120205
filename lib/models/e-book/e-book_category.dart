import 'package:lettutor20120205/models/course/course_category.dart';

class EBookCategory extends CourseCategory {
  EBookCategory({
    String? id,
    String? title,
    String? description,
    String? key,
    String? createdAt,
    String? updatedAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          key: key,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  EBookCategory.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.toJson();
}
