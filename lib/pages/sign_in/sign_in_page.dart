import 'package:classes/base/base_page.dart';
import 'package:classes/logic/sign_in/sign_in_logic.dart';
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
            disableUserGesture: true,
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
      color: Colors.blue,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => logic.liquidController.jumpToPage(page: 3),
            child: Text("登录",style: TextStyle(fontSize: 40))),
          GestureDetector(
            onTap: () => logic.liquidController.animateToPage(page: 1,duration: 700),
            child: Text("注册",style: TextStyle(fontSize: 40)))
        ],
      ),
    );
  }

  Widget chooseIdentity() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("你是", style: TextStyle(fontSize: 20)),
          Container(height: 10),
          GestureDetector(
              onTap: () =>
                  logic.liquidController.animateToPage(page: 2, duration: 700),
              child: Text("教师", style: TextStyle(fontSize: 40))),
          Container(height: 10),
          Text("or", style: TextStyle(fontSize: 25)),
          Container(height: 10),
          GestureDetector(
              onTap: () => logic.liquidController.animateToPage(page: 2,duration: 700),
              child: Text("学生", style: TextStyle(fontSize: 40)))
        ],
      ),
    );
  }

  Widget chooseSchool() {
    return GetBuilder<SignInLogic>(builder: (logic) {
      return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("你来自哪所学校？"),
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
                return Container(
                  height: 34,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    key: Key("22"),
                    controller: textEditingController,
                    focusNode: focusNode,
                    onFieldSubmitted: (value) => onFieldSubmitted(),
                  ),
                );
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
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: logic.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "学号",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                Container(height: 60),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "密码",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                ),
                Container(height: 30),
                RawMaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  onPressed: () {
                    Get.offAndToNamed(Routes.navigation);
                  },
                  child: const Text("确定"),
                )
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