import 'dart:developer';

import 'package:classes/base/base_page.dart';
import 'package:classes/logic/sign_in/sign_in_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SignInPage extends BasePage {
  SignInPage({super.key});

  final data = ["aaaaa", "cajnfoa", "hhokgo"];
  final LiquidController liquidController = LiquidController();
  final logic = Get.find<SignInLogic>();
  late TextEditingController textController;

  @override
  Widget buildWidget(BuildContext context) {
    return Material(
      child: LiquidSwipe(
        enableLoop: false,
        disableUserGesture: true,
        liquidController: liquidController,
        waveType: WaveType.circularReveal,
        pages: [
          chooseIdentity(),
          chooseSchool(),
          completeAccount()
        ],
      ),
    );
  }

  Widget chooseIdentity() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("你是", style: TextStyle(fontSize: 20)),
          Container(height: 10),
          GestureDetector(
              onTap: () =>
                  liquidController.animateToPage(page: 1, duration: 1000),
              child: Text("教师", style: TextStyle(fontSize: 40))),
          Container(height: 10),
          Text("or", style: TextStyle(fontSize: 25)),
          Container(height: 10),
          GestureDetector(
              onTap: () => liquidController.animateToPage(page: 1),
              child: Text("学生", style: TextStyle(fontSize: 40)))
        ],
      ),
    );
  }

  Widget chooseSchool() {
    return GetBuilder<SignInLogic>(builder: (logic) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("你来自哪所学校？"),
            Autocomplete(
              optionsBuilder: (TextEditingValue value) async {
                if (value.text.isEmpty) {
                  return const Iterable<String>.empty();
                } else {
                  return data.where((element) => element.contains(value.text));
                }
              },
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                textController = textEditingController;
                return Container(
                  height: 34,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
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
                        height: 150,
                        child: ListView.builder(
                            itemCount: options.length,
                            itemBuilder: (_, index) =>
                                InkWell(
                                  onTap: () =>
                                      onSelected(options.elementAt(index)),
                                  child: Container(
                                    child: Text.rich(formSpan(
                                        options.elementAt(index),
                                        textController.text)),
                                  ),
                                )),
                      ),
                    ),
                  ),
              displayStringForOption: (option) => option,
              onSelected: (selection) => print(selection),
            ),
          ],
        ),
      );
    });
  }

  Widget completeAccount() {
    return Container(
      color: Colors.green,
    );
  }

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );

  InlineSpan formSpan(String src, String pattern) {
    log(pattern);
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