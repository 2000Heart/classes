import 'dart:developer';

import 'package:classes/pages/navigation_page.dart';
import 'package:classes/pages/sign_in/sign_in_page.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/res/theme.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.initSp();
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
      onInit: () {
        EasyLoading.instance.userInteractions = false;
        log("current user:${UserState.info?.toJson().toString()}");
      },
      builder: EasyLoading.init(),
      locale: const Locale("zh","CN"),
      home: SpUtils.loginAuth == null?SignInPage():NavigationPage(),
    );
  }
}