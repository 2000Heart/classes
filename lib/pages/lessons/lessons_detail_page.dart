import 'package:classes/base/base_page.dart';
import 'package:classes/res/colours.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/states/user_state.dart';
import 'package:classes/utils/utils.dart';
import 'package:classes/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/lessons/lessons_detail_logic.dart';

class LessonsDetailPage extends BasePage {
  LessonsDetailPage({Key? key}) : super(key: key);

  final logic = Get.put(LessonsDetailLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<LessonsDetailLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text(logic.data?.lessonName ?? ''),actions: [
            Container(
                padding: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                child: Text("发布任务",style: TextStyle(color: Colors.black.withOpacity(0.7)))
            ).tap(() => Get.bottomSheet(addTask()))
          ],),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(left: 18,right: 18,top: 20,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("签到",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                      const Text("发布签到",style: TextStyle(fontSize: 14)).tap(() =>
                        Get.toNamed(Routes.lessonCheck,arguments: logic.data?.infoId)),
                    ],
                  )),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(logic.column.length, (index) => Padding(
                        padding: EdgeInsets.only(right: (index != logic.column.length -1)?15:0),
                        child: group(logic.column[index], logic.row[index], index),
                      )),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text("课程任务",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)).paddingSymmetric(horizontal: 16),
                ),
              ),
              SliverList(delegate: SliverChildListDelegate(
                  List.generate(logic.data?.lessonTask?.split(",").length ?? 0, (index) => taskItem(index))
              ))
            ],
          ),
        );
      }
    );
  }

  Widget taskItem(int index){
    String task = logic.data?.lessonTask?.split(",")[index].split("/").join("\n") ?? "";
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
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
              Text("任务${index+1}",style: TextStyle(fontSize: 16),).paddingOnly(top: 2),
            ],
          ).paddingSymmetric(horizontal: 10,vertical: 4),
          Text(task).paddingOnly(left: 16)
        ],
      ),
    );
  }

  Widget group(int column,int row, int num){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(row, (index) => Padding(
        padding: EdgeInsets.only(bottom: index != row - 1?10:0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            column, (childIndex) => Padding(
              padding: EdgeInsets.only(right: childIndex != column - 1?5:0),
              child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.all(3),
                fillColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
                ),
                constraints: const BoxConstraints(minWidth: 40,minHeight: 35,maxWidth: 40,maxHeight: 35),
                onPressed: () {
                  if(logic.signMember[column+row*column] == " "){
                    Get.dialog(checkDialog(column+row*column),barrierColor: Colors.grey.withOpacity(0.1));
                  }
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(logic.signMember[column+row*column].isNullOrEmpty?" ":logic.signMember[num][index+childIndex],style: const TextStyle(fontSize: 12))),
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

  Widget checkDialog(int index){
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 80,maxWidth: 160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: 180,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 10,
                      blurStyle: BlurStyle.solid,
                      offset: Offset(3, -4)
                  )],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  color: Colors.white
                ),
                child: Text("确定这个位置吗？"))),
            Container(height: 6),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 87,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5,
                          blurStyle: BlurStyle.solid,
                          offset: Offset(3, 4)
                      )],
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                      color: Colors.white
                    ),
                    child: Text("否")).tap(Get.back),
                  Container(width: 6),
                  Container(
                    width: 87,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5,
                          blurStyle: BlurStyle.solid,
                          offset: Offset(3, 4)
                      )],
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
                      color: Colors.white
                    ),
                    child: Text("是")).tap(() {
                      logic.updateCheck(index);
                      Get.back();
                    }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
