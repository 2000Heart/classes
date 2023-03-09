import 'package:cached_network_image/cached_network_image.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/mine/mine_logic.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/res/styles.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MinePage extends BasePage{
  MinePage({super.key});

  final controller = Get.put(MineLogic());
  @override
  Widget buildWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(8, 8)
                    )
                  ]
              ),
              child: CachedNetworkImage(
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, str) => Container(color: Colors.white),
                  errorWidget: (context,url,error) => Icon(Icons.ac_unit,size: 90),
                  imageUrl: UserState.info?.avatar ?? 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202104%2F22%2F20210422220415_2e4bd.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1680746191&t=ddb4b41f1676fbe35e1c2546bf472d0b'),
            ),
            Container(height: 40),
            Text(UserState.info?.userName ?? "",style: TextStyle(fontSize: 25)),
            Container(height: 6),
            Text(UserState.info?.school ?? "",style: TextStyle(fontSize: 14)),
            Container(height: 60),
            if(UserState.info?.userType == 1)option(Icons.add, "我的班级").tap(() => Get.toNamed(Routes.myClass)),
            option(Icons.add, "我的课程").tap(() => Get.toNamed(Routes.myReview)),
            option(Icons.access_alarm, "我的记录").tap(() => Get.toNamed(Routes.myReview)),
            option(Icons.add, "用户设置").tap(() => Get.toNamed(Routes.mySetting)),
            option(Icons.add, "应用设置").tap(() => Get.toNamed(Routes.setting))
          ],
        ),
      ),
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
                  child: Icon(size: 25, icon)),
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