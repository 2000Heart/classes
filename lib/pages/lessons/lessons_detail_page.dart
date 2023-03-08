import 'package:classes/base/base_page.dart';
import 'package:classes/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/lessons/lessons_detail_logic.dart';

class LessonsDetailPage extends BasePage {
  LessonsDetailPage({Key? key}) : super(key: key);

  final logic = Get.put(LessonsDetailLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("形式与政策")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 20),
                Container(padding: EdgeInsets.symmetric(horizontal: 18),child: const Text("签到",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500))),
                Container(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        group(5, 2),
                        Container(width: 15),
                        group(4, 4),
                        Container(width: 15),
                        group(3, 3)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 15),
                Text("课程任务",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)).paddingSymmetric(horizontal: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colours.RED_LIGHT,Colours.white]),
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                blurStyle: BlurStyle.solid,
                                offset: Offset(3, 2)
                            )],
                          ),
                        ),
                        Container(width: 10),
                        Text("任务2",style: TextStyle(fontSize: 16),).paddingOnly(top: 2),
                      ],
                    ).paddingSymmetric(horizontal: 16,vertical: 4),
                    Text("1.今天要把作业2完成；\n2.完成预习").paddingSymmetric(horizontal: 26)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colours.RED_LIGHT,Colours.white]),
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                blurStyle: BlurStyle.solid,
                                offset: Offset(3, 2)
                            )],
                          ),
                        ),
                        Container(width: 10),
                        Text("任务1",style: TextStyle(fontSize: 16),).paddingOnly(top: 2),
                      ],
                    ).paddingSymmetric(horizontal: 16,vertical: 4),
                    Text("1.今天要把作业2完成；\n2.完成预习").paddingSymmetric(horizontal: 26)
                  ],
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget group(int column,int row){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(column, (index) => Padding(
        padding: EdgeInsets.only(bottom: index != column - 1?10:0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            row, (index) => Padding(
              padding: EdgeInsets.only(right: index != row - 1?5:0),
              child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(3),
                fillColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
                ),
                constraints: BoxConstraints(minWidth: 40,minHeight: 35,maxWidth: 40,maxHeight: 35),
                onPressed: () { Get.back(); },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("张三张",style: TextStyle(fontSize: 12))),
              ),
            )
          ),
        ),
      )
      ),
    );
  }
}
