import 'package:classes/pages/home/home_page.dart';
import 'package:classes/pages/lessons/lessons_page.dart';
import 'package:classes/pages/mine/mine_page.dart';
import 'package:get/get.dart';

class Routes {
  static const home = "/home";
  static const lessons = "/lessons";
  static const mine = "/mine";

  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: lessons, page: () => LessonsPage()),
    GetPage(name: mine, page: () => MinePage())
  ];
}