import 'package:classes/pages/home/home_page.dart';
import 'package:classes/pages/lessons/lessons_page.dart';
import 'package:classes/pages/mine/mine_page.dart';
import 'package:classes/pages/navigation_page.dart';
import 'package:classes/pages/sign_in/sign_in_page.dart';
import 'package:get/get.dart';

class Routes {
  static const sign = "/sign";
  static const navigation = "/navigation";
  static const home = "/home";
  static const lessons = "/lessons";
  static const mine = "/mine";

  static final List<GetPage> getPages = [
    GetPage(name: sign, page: () => SignInPage()),
    GetPage(name: navigation, page: () => NavigationPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: lessons, page: () => LessonsPage()),
    GetPage(name: mine, page: () => MinePage())
  ];
}