import 'package:classes/logic/mine/password_logic.dart';
import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({Key? key}) : super(key: key);

  final PasswordLogic logic = Get.put(PasswordLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text("修改密码"),actions: [
            Container(
                padding: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                child: Text("保存",style: TextStyle(color: Colors.black.withOpacity(0.7))).tap(logic.updatePsw))
          ]),
          body: Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  [Expanded(child: Text("原密码")),
                    Expanded(child: text(
                        "输入原密码",
                        onChanged: (str) => logic.oldPsw = str,
                        onSubmitted: (str) => logic.oldPsw = str))].formLine(),
                  [Expanded(child: Text("新密码")),
                    Expanded(child: text(
                        "输入新密码",
                        onChanged: (str) => logic.newPsw = str,
                        onSubmitted: (str) => logic.newPsw = str))].formLine(),
                ],
              )
          ),
        );
      }
    );
  }

  Widget text(String text,
      {ValueChanged<String>? onChanged,
        ValueChanged<String>? onSubmitted}
      ){
    return TextField(
      cursorColor: Colors.black,
      obscureText: true,
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(color: Colors.black),
        // contentPadding: const EdgeInsets.symmetric(vertical: 5),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
