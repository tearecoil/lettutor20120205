import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor20120205/components/course_card.dart';
import 'package:lettutor20120205/components/course_list.dart';
import 'package:lettutor20120205/components/drop_down.dart';
import 'package:lettutor20120205/components/multi_choice_drop_down.dart';
import 'package:lettutor20120205/models/course/course.dart';
import 'package:lettutor20120205/service-api/courses-services.dart';
import 'package:lettutor20120205/service-api/misc-services.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

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

final coursesLevelSort = {
  'ASC': 'Level ascending',
  'DESC': 'Level descending',
};

class _CoursePageState extends State<CoursePage> {
  Map<String, String>? _categoryList;
  final Map<String, String> _levelList = coursesLevel;
  final Map<String, String> _sortList = coursesLevelSort;

  final TextEditingController _searchController = TextEditingController();
  final List<String> _selectedCategory = [];
  final List<String> _selectedLevel = [];
  final TextEditingController _levelController = TextEditingController();

  final ValueNotifier<Map<String, dynamic>> _searchList = ValueNotifier({});
  Future<List<Course>>? _courses;

  @override
  void initState() {
    super.initState();
    _getContentCategory();
    _searchList.value = {
      'search': _searchController.text,
      'categoryId': _selectedCategory,
      'level': _selectedLevel,
      'orderBy': _levelController.text,
    };
    _getCourseList();
  }

  void _getContentCategory() async {
    await MiscService.getCategory(
      onSuccess: (levelList) {
        setState(() {
          _categoryList = {};
          for (final level in levelList) {
            _categoryList![level.id!] = level.title!;
          }
        });
      },
      onError: (message) {},
    );
  }

  void _onSearchChanged(String value) {
    _searchList.value = {
      ..._searchList.value,
      'search': value,
    };
    _getCourseList();
  }

  void _onLevelChanged(List<String> value) {
    _searchList.value = {
      ..._searchList.value,
      'level': value,
    };
    _getCourseList();
  }

  void _onCategoryChanged(List<String> value) {
    _searchList.value = {
      ..._searchList.value,
      'categoryId': value,
    };
    _getCourseList();
  }

  void _onLevelSortChanged(String value) {
    _searchList.value = {
      ..._searchList.value,
      'orderBy': value,
    };
    _getCourseList();
  }

  void _getCourseList() {
    CoursesService.searchCourse(
      page: 1,
      size: 100,
      search: _searchList.value['search'],
      categoryId: _searchList.value['categoryId'],
      level: _searchList.value['level'],
      orderBy: _searchList.value['orderBy'],
      onSuccess: (courses) {
        _sortCourses(courses);
      },
      onError: (message) {},
    );
  }

  void _sortCourses(List<Course> courses) {
    Map<String, List<Course>> courseMap = {};
    for (var course in courses) {
      final String key = course.categories?.first.key ?? 'null key';
      if (courseMap.containsKey(key)) {
        courseMap[key]!.add(course);
      } else {
        courseMap[key] = [course];
      }
    }
    final List<Course> sortedCourses = [];
    courseMap.forEach((key, value) {
      sortedCourses.addAll(value);
    });

    setState(() {
      _courses = Future.value(sortedCourses);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _levelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 6, top: 10),
              child: const Text(
                "Courses",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Search',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _searchController,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                hintStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'Search',
                suffixIcon: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.search),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Level',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            MultiChoiceDropDown(
              items: _levelList,
              selectedItems: _selectedLevel,
              hintText: 'Select level',
              onSelected: _onLevelChanged,
            ),
            const SizedBox(height: 12),
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            MultiChoiceDropDown(
              items: _categoryList ?? {},
              selectedItems: _selectedCategory,
              hintText: 'Select category',
              onSelected: _onCategoryChanged,
            ),
            const SizedBox(height: 12),
            const Text(
              'Sort by Level',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            DropDownField(
              controller: _levelController,
              list: _sortList,
              hintText: 'Sort by level',
              onSelected: _onLevelSortChanged,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 2000,
                height: MediaQuery.of(context).size.height * 0.3,
                child: FutureBuilder(
                  future: _courses,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Course> courses =
                          snapshot.data as List<Course>;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: courses.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              CourseCard(course: courses[index]),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
