import 'package:classes/base/base_page.dart';
import 'package:classes/res/colours.dart';
import 'package:classes/res/utils.dart';
import 'package:classes/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/lessons/lessons_detail_logic.dart';

class LessonsDetailPage extends BasePage {
  LessonsDetailPage({Key? key}) : super(key: key);

  final logic = Get.put(LessonsDetailLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("形式与政策"),actions: [
        Container(
            padding: const EdgeInsets.only(right: 16),
            alignment: Alignment.center,
            child: Text("发布任务",style: TextStyle(color: Colors.black.withOpacity(0.7)))
        ).tap(() => Get.bottomSheet(addTask()))
      ],),
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
                Container(
                  margin: EdgeInsets.only(bottom: 10,top: 10,right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                  BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                  blurStyle: BlurStyle.solid,
                  offset: Offset(5, 5)
                  )]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
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
                      Text("1.今天要把作业2完成；\n2.完成预习").paddingOnly(left: 26)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10,top: 10,right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 2,
                            blurStyle: BlurStyle.solid,
                            offset: Offset(5, 5)
                        )]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
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
                      Text("1.今天要把作业2完成；\n2.完成预习大三大四的撒大叔大叔大叔大叔大叔大叔的").paddingOnly(left: 26)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10,top: 10,right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 2,
                            blurStyle: BlurStyle.solid,
                            offset: Offset(5, 5)
                        )]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
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
                      Text("1.今天要把作业2完成；\n2.完成预习dasdasdasdasdaasda").paddingOnly(left: 26)
                    ],
                  ),
                ),
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

  Widget addTask(){
    return BottomSheet(
      elevation: 40,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(16))
      ),
      constraints: BoxConstraints(minHeight: 490,maxHeight: 490),
      builder: (BuildContext context) =>Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          [Text("标题",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
            SizedBox(
            width: 100,
            child: TextField(
              cursorColor: Colors.black,
              expands: true,
              maxLines: null,
              minLines: null,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: '请输入任务标题',
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          )].formLine().paddingOnly(top: 10,left: 16,right: 16),
          [Text("内容",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
            NormalButton(text: "发布",width: 80,height: 30)].formLine().paddingOnly(left: 16,right: 16,bottom: 10),
          Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35 / 2),
              boxShadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
              )]
            ),
            child: TextField(
              maxLines: 15,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none
              ),
            ),
          )
        ],
      ), onClosing: () {  },
    );
  }
}
