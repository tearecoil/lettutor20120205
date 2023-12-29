import 'package:lettutor20120205/models/course/course_category.dart';
import 'package:lettutor20120205/models/course/course_topic.dart';
import 'package:lettutor20120205/models/user/User.dart';

class Course {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  bool? visible;
  String? createdAt;
  String? updatedAt;
  List<CourseTopic>? topics;
  List<CourseCategory>? categories;
  List<User>? users;

  Course({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories,
    this.users,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    reason = json['reason'];
    purpose = json['purpose'];
    otherDetails = json['other_details'];
    defaultPrice = json['default_price'];
    coursePrice = json['course_price'];
    visible = json['visible'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    topics = json['topics']?.map<CourseTopic>((topic) {
      return CourseTopic.fromJson(topic);
    }).toList();
    categories = json['categories']?.map<CourseCategory>((category) {
      return CourseCategory.fromJson(category);
    }).toList();
    users = json['users']?.map<User>((user) {
      return User.fromJson(user);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['level'] = level;
    data['reason'] = reason;
    data['purpose'] = purpose;
    data['other_details'] = otherDetails;
    data['default_price'] = defaultPrice;
    data['course_price'] = coursePrice;
    data['visible'] = visible;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['topics'] = topics?.map((topic) => topic.toJson()).toList();
    data['categories'] =
        categories?.map((category) => category.toJson()).toList();
    data['users'] = users?.map((user) => user.toJson()).toList();
    return data;
  }
}
