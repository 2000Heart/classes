import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/sign_in/sign_in_logic.dart';
import 'package:classes/res/colours.dart';
import 'package:classes/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../res/routes.dart';

class SignInPage extends BasePage {
  SignInPage({super.key});

  final logic = Get.put(SignInLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return Material(
      child: GetBuilder<SignInLogic>(
        builder: (logic) {
          return LiquidSwipe(
            enableLoop: false,
            disableUserGesture: false,
            liquidController: logic.liquidController,
            waveType: WaveType.circularReveal,
            pages: [
              chooseToSign(),
              chooseIdentity(),
              chooseSchool(),
              completeAccount()
            ],
          );
        }
      ),
    );
  }

  Widget chooseToSign(){
    return Container(
      color: Colours.grey5,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("简之",style: TextStyle(fontSize: 40)),
          Container(height: 300),
          NormalButton(
            onTap: () => logic.liquidController.jumpToPage(page: 3),
            child: Text("登录",style: TextStyle(fontSize: 40))),
          Container(height: 40),
          NormalButton(
              onTap: () => logic.liquidController.animateToPage(page: 1,duration: 700),
              child: Text("注册",style: TextStyle(fontSize: 40))),
        ],
      ),
    );
  }

  Widget chooseIdentity() {
    return Container(
      color: Colours.grey1,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("你是", style: TextStyle(fontSize: 25)),
          Container(height: 40),
          NormalButton(
              onTap: () => logic.liquidController.animateToPage(page: 2, duration: 700),
              child: Text("教师",style: TextStyle(fontSize: 40))),
          Container(height: 10),
          Text("or", style: TextStyle(fontSize: 30)),
          Container(height: 10),
          NormalButton(
              onTap: () => logic.liquidController.animateToPage(page: 2,duration: 700),
              child: Text("学生", style: TextStyle(fontSize: 40)))
        ],
      ),
    );
  }

  Widget chooseSchool() {
    return GetBuilder<SignInLogic>(builder: (logic) {
      return Container(
        color: Colours.grey2,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Autocomplete(
              optionsBuilder: (TextEditingValue value) async {
                if (value.text.isEmpty) {
                  return const Iterable<String>.empty();
                } else {
                  return logic.data.where((element) => element.contains(value.text));
                }
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                logic.textController = textEditingController;
                return TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    labelText: "你来自哪所学校？",
                    labelStyle: TextStyle(color: Colors.black),

                  ),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (value) => onFieldSubmitted(),
                ).paddingSymmetric(horizontal: 40);
              },
              optionsViewBuilder: (context, onSelected, options) =>
                  Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      child: Container(
                        color: Colors.green,
                        margin: EdgeInsets.only(top: 20),
                        height: (50 * options.length).toDouble(),
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (_, index) =>
                                  InkWell(
                                    onTap: () =>
                                        onSelected(options.elementAt(index)),
                                    child: Container(
                                      width: Get.width,
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      child: Text.rich(formSpan(
                                          options.elementAt(index),
                                          logic.textController.text)),
                                    ),
                                  )),
                        ),
                      ),
                    ),
                  ),
              displayStringForOption: (option) => option,
              onSelected: (selection) => logic.liquidController.animateToPage(page: 3,duration: 700),
            ),
          ],
        ),
      );
    });
  }

  Widget completeAccount() {
    return GetBuilder<SignInLogic>(
      builder: (logic) {
        return Container(
          color: Colours.cyan1,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    labelText: "学号",
                    labelStyle: TextStyle(color: Colors.black)),
                  onChanged: (text) => logic.username = text,
                  onFieldSubmitted: (text) => logic.username = text,
                ),
                Container(height: 60),
                TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    labelText: "密码",
                    labelStyle: TextStyle(color: Colors.black)),
                  onChanged: (text) => logic.password = text,
                  onFieldSubmitted: (text) => logic.password = text,
                ),
                Container(height: 30),
                NormalButton(
                  onTap: () => Get.toNamed(Routes.navigation), //logic.checkLogin(),
                  child: const Text("确定",style: TextStyle(fontSize: 24),),
                ),
                Text(logic.user.toString())
              ],
            ),
          ),
        );
      }
    );
  }

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );

  InlineSpan formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    List<String> parts = src.split(pattern);
    if (parts.length > 1) {
      for (int i = 0; i < parts.length; i++) {
        span.add(TextSpan(text: parts[i]));
        if (i != parts.length - 1) {
          span.add(TextSpan(text: pattern, style: lightTextStyle));
        }
      }
    } else {
      span.add(TextSpan(text: src));
    }
    return TextSpan(children: span);
  }

}