import 'package:classes/base/base_page.dart';
import 'package:classes/logic/lessons/lessons_logic.dart';
import 'package:classes/model/lessons/lesson_entity.dart';
import 'package:classes/res/colours.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LessonsPage extends BasePage{
  LessonsPage({super.key});

  final logic = Get.put(LessonsLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<LessonsLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Icon(Icons.add).tap(() => Get.toNamed(Routes.lessonAdd)),
              Icon(Icons.schedule).tap(() => Get.toNamed(Routes.lessonCheck))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(logic.lessons.length, (index) => lessonsListItem(logic.lessons[index])),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget lessonsListItem(Lesson entity){
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.lessonsDetail,arguments: entity),
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(bottom: 10,top: 10,left: 12,right: 12),
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2,
              blurStyle: BlurStyle.solid,
              offset: Offset(5, 5)
            )
          ],
          borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entity.lessonName ?? "",style: TextStyle(fontSize: 18)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                  child: Text("进行中",style: TextStyle(fontSize: 10))),
              ],
            ),
            Container(
              width: 100,
              height: 2,
              margin: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colours.SIGNUP_RED,Colours.PURPLE])),
            ),
            Container(height: 4),
            Text(entity.teacherName ?? '',style: TextStyle(fontSize: 16)),
            // Container(height: 4),
            // Text("2308",style: TextStyle(fontSize: 14))
          ],
        ),
      ),
    );
  }
}