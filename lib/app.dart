import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:lettutor20120205/detail-courses-widgets/ChaptersScreen/chap1.dart';
import 'package:lettutor20120205/detail-courses-widgets/ChaptersScreen/chap2.dart';
import 'package:lettutor20120205/detail-courses-widgets/ChaptersScreen/chap3.dart';
import 'package:lettutor20120205/detail-courses-widgets/ChaptersScreen/chap4.dart';
import 'package:lettutor20120205/detail-courses-widgets/ChaptersScreen/chap5.dart';
import 'package:lettutor20120205/detail-courses-widgets/ChaptersScreen/chap6.dart';
import 'package:lettutor20120205/detail-courses-widgets/ChaptersScreen/chap7.dart';
import 'package:lettutor20120205/detail-courses-widgets/courses_info.dart';
import 'package:lettutor20120205/tutor_pages/reviews.dart';
import 'package:lettutor20120205/tutor_pages/tutor_profile.dart';
import 'package:lettutor20120205/intro-screens/forgot_password.dart';
import 'package:lettutor20120205/intro-screens/login.dart';
import 'package:lettutor20120205/intro-screens/menu.dart';
import 'package:lettutor20120205/intro-screens/signup.dart';
import 'package:lettutor20120205/video-call/video_call.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/login":
              return MaterialPageRoute(builder: (context) => MainLogin());
            case "/signup":
              return MaterialPageRoute(builder: (context) => SignUpPage());
            case "/fgpass":
              return MaterialPageRoute(builder: (context) => ForgotPassword());
            case "/home":
              return MaterialPageRoute(builder: (context) => const MainMenu());
            // case "/reviews":
            //   return MaterialPageRoute(builder: (context) => Reviews());
            // case "/tutorpro":
            //   return MaterialPageRoute(builder: (context) => TutorProfile());
            case "/couover":
              return MaterialPageRoute(
                  builder: (context) => const CourseOverview());
            case "/video":
              return MaterialPageRoute(
                  builder: (context) => const LessonPage());
            case "/chap1":
              return MaterialPageRoute(builder: (context) => const Chap1());
            case "/chap2":
              return MaterialPageRoute(builder: (context) => const Chap2());
            case "/chap3":
              return MaterialPageRoute(builder: (context) => const Chap3());
            case "/chap4":
              return MaterialPageRoute(builder: (context) => const Chap4());
            case "/chap5":
              return MaterialPageRoute(builder: (context) => const Chap5());
            case "/chap6":
              return MaterialPageRoute(builder: (context) => const Chap6());
            case "/chap7":
              return MaterialPageRoute(builder: (context) => const Chap7());
            default:
              return MaterialPageRoute(builder: (context) => MainLogin());
          }
        },
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue, primaryColor: const Color(0xff007CFF)),
        home: MainLogin());
  }
}
