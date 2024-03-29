import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/mine/mine_logic.dart';
import 'package:classes/res/nav_icons.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/res/styles.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MinePage extends BasePage{
  MinePage({super.key});

  final logic = Get.put(MineLogic());
  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<MineLogic>(
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFe8ddc2),Color(0xFFC9E8E1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
          padding: EdgeInsets.only(top: 16+MediaQuery.of(context).padding.top),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(width: Get.width,Utils.getImgPath("big_cat.png"))),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Column()),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(8, 8)
                              )
                            ]
                        ),
                        child: CachedNetworkImage(
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, str) => Container(color: Colors.white),
                            errorWidget: (context,url,error) => CachedNetworkImage(imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202104%2F22%2F20210422220415_2e4bd.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1680746191&t=ddb4b41f1676fbe35e1c2546bf472d0b'),
                            imageUrl: UserState.info?.avatar ?? ""),
                      ).tap(() => logic.pic = !logic.pic),
                      Expanded(child: Column(
                        children: [
                          if(logic.pic)Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedTextKit(
                                  onTap: () => Utils.pickPhotoFormGallery(),
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    FadeAnimatedText("从相册中选择",duration: const Duration(seconds: 10),fadeInEnd: 0.1,fadeOutBegin: 0.9),
                                  ],
                                  onFinished: () => logic.pic = !logic.pic,
                                ),
                                Container(height: 16),
                                AnimatedTextKit(
                                  onTap: () => Utils.pickPhotoFormCamera(),
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    FadeAnimatedText("手机拍摄",duration: const Duration(seconds: 10),fadeInEnd: 0.1,fadeOutBegin: 0.9),
                                  ],
                                  onFinished: () => logic.pic = !logic.pic,
                                )
                              ],
                            ),
                          )

                        ],
                      ))
                    ],
                  ),
                  Container(height: 40),
                  Text(UserState.info?.userName ?? "",style: TextStyle(fontSize: 25)),
                  Container(height: 6),
                  Text(UserState.info?.school ?? "",style: TextStyle(fontSize: 14)),
                  Container(height: 60),
                  if(UserState.info?.userType == 1)
                  option("我的班级",icon: NavIcons.classes,).tap(() => Get.toNamed(Routes.myClass)),
                  // option(Icons.add, "我的课程").tap(() => Get.toNamed(Routes.myReview)),
                  option("我的记录",image: "cat_time.png").tap(() => Get.toNamed(Routes.myReview)),
                  option("用户设置",image: "cat_set.png").tap(() => Get.toNamed(Routes.mySetting)),
                  option("应用设置",image: "setting.png").tap(() => Get.toNamed(Routes.setting))
                ],
              ),
            ],
          ),
        );
      }
    );
  }
  Widget option(String title, {void Function()? onTap, String? image,IconData? icon}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 2,
                        blurStyle: BlurStyle.solid,
                        offset: Offset(3, 2)
                    )],
                  ),
                  child: image != null?Image.asset(Utils.getImgPath(image)):Icon(size: 25, icon)),
                const SizedBox(width: 18),
                Text(title, style: const TextStyle(fontSize: 15)),
                const Spacer(),
                const Icon(size: 18, Icons.arrow_forward_ios)
              ],
            ),
          )
        ],
      ).marginSymmetric(horizontal: 16),
    );
  }
}