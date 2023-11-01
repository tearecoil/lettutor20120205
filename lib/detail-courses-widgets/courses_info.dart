import 'package:flutter/material.dart';
import 'package:lettutor20120205/components/chapter_card.dart';
//import 'package:lettutor20120205/components/chapter_list.dart';

class CourseOverview extends StatefulWidget {
  const CourseOverview({super.key});

  @override
  State<CourseOverview> createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverview> {
  @override
  Widget build(BuildContext context) {
    List<Widget> chapterList = [
      ChapterCard(
        name: "What is a Pokemon?",
        chapterNumber: 1,
        tag: "Basic info of a Pokemon",
        onTap: () {
          Navigator.pushNamed(context, "/chap1");
        },
      ),
      ChapterCard(
        name: "What is a Pokeball?",
        chapterNumber: 2,
        tag: "A usefull ball? What will it do?",
        onTap: () {
          Navigator.pushNamed(context, "/chap2");
        },
      ),
      ChapterCard(
        name: "Catching a Pokemon",
        chapterNumber: 3,
        tag: "A friend? A pet? Whatever you name it",
        onTap: () {
          Navigator.pushNamed(context, "/chap3");
        },
      ),
      ChapterCard(
        name: "Pokemon's rank and how it will affect?",
        chapterNumber: 4,
        tag: "Can't catch them all",
        onTap: () {
          Navigator.pushNamed(context, "/chap4");
        },
      ),
      ChapterCard(
        name: "Duel",
        chapterNumber: 5,
        tag: "Something interesting",
        onTap: () {
          Navigator.pushNamed(context, "/chap5");
        },
      ),
      ChapterCard(
        name: "How to use EXP and items from winning?",
        chapterNumber: 6,
        tag: "Unless you lose",
        onTap: () {
          Navigator.pushNamed(context, "/chap6");
        },
      ),
      ChapterCard(
        name: "Low HP Pokemon?",
        chapterNumber: 7,
        tag: "Now we can catch them",
        onTap: () {
          Navigator.pushNamed(context, "/chap7");
        },
      ),
    ];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                height: size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/tutor_pic.png"),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Pokemon 101",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "by Teacher K",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Text(
                                  "Written in 2023",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 50,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.question_mark,
                          color: Colors.red,
                        ),
                        Text(
                          "Overview",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Some basic stategies to catch normal Pokemons",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.book,
                          color: Colors.red,
                        ),
                        Text(
                          "Chapters List",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chapterList.length,
                itemBuilder: (context, index) => chapterList[index]),
          ),
          SizedBox(
            height: 50,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        Text(
                          "Experience Level",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Newbies",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
