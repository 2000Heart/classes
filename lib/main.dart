import 'package:classes/pages/sign_in/sign_in_page.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/res/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '课程管理',
      getPages: Routes.getPages,
      theme: ThemeConfig.theme(),
      home: Scaffold(body: SignInPage()),
    );
  }
}