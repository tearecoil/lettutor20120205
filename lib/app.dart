import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:lettutor20120205/detail-courses-widgets/courses_info.dart';
import 'package:lettutor20120205/my-profile/become_tutor.dart';
import 'package:lettutor20120205/my-profile/student-profile.dart';
import 'package:lettutor20120205/providers/theme/theme_provider.dart';
import 'package:lettutor20120205/tutor_pages/reviews.dart';
// import 'package:lettutor20120205/tutor_pages/view_tutor_profile.dart';
import 'package:lettutor20120205/intro-screens/forgot_password.dart';
import 'package:lettutor20120205/intro-screens/login.dart';
import 'package:lettutor20120205/intro-screens/menu.dart';
import 'package:lettutor20120205/intro-screens/signup.dart';
import 'package:lettutor20120205/video-call/video_call.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).getThemeMode(),
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
            case "/becometutor":
              return MaterialPageRoute(
                  builder: (context) => const BecomeTutorScreen());
            case "/studentprofile":
              return MaterialPageRoute(
                  builder: (context) => MyStudentProfile());
            // case "/teacherprofile":
            //   return MaterialPageRoute(builder: (context) => MyTutorProfile());
            // case "/reviews":
            //   return MaterialPageRoute(builder: (context) => Reviews());
            // case "/tutorpro":
            //   return MaterialPageRoute(builder: (context) => TutorProfile());
            // case "/couover":
            //   return MaterialPageRoute(
            //       builder: (context) => const CourseOverview());
            case "/video":
              return MaterialPageRoute(
                  builder: (context) => const LessonPage());
            default:
              return MaterialPageRoute(builder: (context) => MainLogin());
          }
        },
        title: 'Flutter Demo',
        home: MainLogin());
  }
}
