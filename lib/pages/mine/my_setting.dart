import 'package:classes/base/base_page.dart';
import 'package:classes/logic/mine/my_setting_logic.dart';
import 'package:classes/res/routes.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySetting extends BasePage{
  MySetting({super.key});

  final MySettingLogic logic = Get.put(MySettingLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<MySettingLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text("我的设置"),actions: [
            Container(
                padding: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                child: Text(logic.read?"编辑":"保存",style: TextStyle(color: Colors.black.withOpacity(0.7))).tap(() {
                  if(logic.read){
                    logic.read = !logic.read;
                  }else{
                    logic.updateData();
                  }
                }))
          ],),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          blurStyle: BlurStyle.solid,
                          offset: Offset(5, 5)
                      )
                    ]
                ),
                child: Column(
                  children: [
                    [Expanded(child: Text("账号")),
                      Expanded(child: text(
                        logic.user.account ?? "",
                        readOnly: logic.read,
                        onChanged: (str) => logic.account = str,
                        onSubmitted: (str) => logic.account = str))].formLine(),
                    [Expanded(child: Text("姓名")),
                      Expanded(child: text(
                          logic.user.userName ?? "",
                          readOnly: logic.read,
                          onChanged: (str) => logic.userName = str,
                          onSubmitted: (str) => logic.userName = str))].formLine(),
                  ],
                )
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            blurStyle: BlurStyle.solid,
                            offset: Offset(5, 5)
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      [Expanded(child: Text("学校")),
                        Expanded(child: text(
                            logic.user.school ?? "",
                            readOnly: logic.read,
                            onChanged: (str) => logic.school = str,
                            onSubmitted: (str) => logic.school = str))].formLine(),
                      [Expanded(child: Text("班级")),
                        Expanded(child: text(
                            logic.user.className ?? "",
                            readOnly: logic.read,
                            onChanged: (str) => logic.className = str,
                            onSubmitted: (str) => logic.className = str))].formLine(),
                    ],
                  )
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            blurStyle: BlurStyle.solid,
                            offset: Offset(5, 5)
                        )
                      ]
                  ),
                  child: [Text("密码"),
                    Icon(Icons.arrow_forward_ios_rounded)].formLine()
                      .tap(() => Get.toNamed(Routes.password))
              )
            ],
          )
        );
      }
    );
  }

  Widget text(String text,
    {required bool readOnly,
      ValueChanged<String>? onChanged,
      ValueChanged<String>? onSubmitted}
    ){
    return Container(
      height: 20,
      alignment: Alignment.center,
      child: TextField(
        cursorColor: Colors.black,
        readOnly: readOnly,
        expands: true,
        maxLines: null,
        minLines: null,
        textAlign: TextAlign.end,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(vertical: 1),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}