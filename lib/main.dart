import 'dart:developer';
import 'package:classes/pages/navigation_page.dart';
import 'package:classes/pages/sign_in/sign_in_page.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/res/theme.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtils.initSp();
  runApp(const MyApp());
  if(GetPlatform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '课程管理',
      getPages: Routes.getPages,
      theme: ThemeConfig.theme(),
      onInit: () {
        EasyLoading.instance.userInteractions = false;
        log("current user:${UserState.info?.toJson().toString()}");
      },
      initialRoute: '/',
      builder: EasyLoading.init(),
      locale: const Locale("zh","CN"),
      home: RootPage(),
    );
  }
}

class RootPage extends StatelessWidget{
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SpUtils.loginAuth == null?SignInPage():NavigationPage();
  }

}