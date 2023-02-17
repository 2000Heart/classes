import 'package:cached_network_image/cached_network_image.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/mine/mine_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/utils.dart';


class MinePage extends BasePage{
  MinePage({super.key});

  final controller = Get.put(MineLogic());
  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          errorWidget: (context,url,error) => Icon(Icons.ac_unit),
          imageUrl: ''),
        Text("张三"),
        Text("浙江万里学院"),
        option(Icons.add, "我的作业"),
        option(Icons.access_alarm, "签到记录"),
        option(Icons.add, "用户设置"),
        option(Icons.add, "应用设置"),
      ],
    );
  }
  Widget option(IconData icon, String title, {void Function()? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(size: 25, icon),
                const SizedBox(width: 10),
                Text(title, style: TextStyle(fontSize: 15),),
                const Spacer(),
                Icon(size: 20, Icons.arrow_forward_ios)
              ],
            ),
          ),
        ],
      ).marginSymmetric(horizontal: 16),
    );
  }
}