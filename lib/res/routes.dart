import 'package:classes/pages/home/home_detail_page.dart';
import 'package:classes/pages/home/home_page.dart';
import 'package:classes/pages/lessons/lesson_add_check_page.dart';
import 'package:classes/pages/lessons/lessons_detail_page.dart';
import 'package:classes/pages/lessons/lessons_page.dart';
import 'package:classes/pages/mine/mine_page.dart';
import 'package:classes/pages/navigation_page.dart';
import 'package:get/get.dart';

import '../pages/home/home_add_lesson_page.dart';
import '../pages/lessons/lesson_add_page.dart';
import '../pages/sign_in/sign_in_page.dart';

class Routes {
  static const sign = "/sign";
  static const navigation = "/navigation";
  static const home = "/home";
  static const homeAdd = "/home/homeAdd";
  static const lessons = "/lessons";
  static const lessonAdd = "/lessons/lessonAdd";
  static const lessonCheck = "/lessons/lessonCheck";
  static const mine = "/mine";
  static const homeDetail = "/home/homeDetail";
  static const lessonsDetail = "/lessons/lessonsDetail";

  static final List<GetPage> getPages = [
    GetPage(name: sign, page: () => SignInPage()),
    GetPage(name: navigation, page: () => NavigationPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: lessons, page: () => LessonsPage()),
    GetPage(name: mine, page: () => MinePage()),
    GetPage(
      name: homeDetail, page: () => HomeDetailPage(),
      opaque: false,
    ),
    GetPage(name: lessonsDetail, page: () => LessonsDetailPage()),
    GetPage(name: homeAdd, page: () => HomeAddLessonPage()),
    GetPage(name: lessonAdd, page: () => LessonAddPage()),
    GetPage(name: lessonCheck, page: () => LessonAddCheckPage())
  ];
}