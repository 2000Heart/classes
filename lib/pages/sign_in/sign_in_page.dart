import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/sign_in/sign_in_logic.dart';
import 'package:classes/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../res/routes.dart';
import '../../widgets/button.dart';

class SignInPage extends BasePage {
  SignInPage({super.key});

  final logic = Get.put(SignInLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return Material(
      child: GetBuilder<SignInLogic>(
        initState: (state){
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: SystemUiOverlay.values);
        },
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
      // decoration: BoxDecoration(
      //   gradient:
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("简之",style: TextStyle(fontSize: 40)),
          Container(height: 300),
          NormalButton(
            width: 200,
            height: 70,
            onTap: () => logic.liquidController.jumpToPage(page: 3),
            text: "登录",
            textStyle: const TextStyle(fontSize: 25)),
          Container(height: 40),
          NormalButton(
              width: 200,
              height: 70,
              onTap: () => logic.liquidController.animateToPage(page: 1,duration: 700),
              text: "注册",
              textStyle: const TextStyle(fontSize: 25)),
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
              text: "教师",
              textStyle: TextStyle(fontSize: 40)),
          Container(height: 10),
          Text("or", style: TextStyle(fontSize: 30)),
          Container(height: 10),
          NormalButton(
              onTap: () => logic.liquidController.animateToPage(page: 2,duration: 700),
              text: "学生",
              textStyle: TextStyle(fontSize: 40))
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
                fieldColorBox("学号", logic.username),
                Container(height: 60),
                fieldColorBox("密码", logic.password),
                // TextFormField(
                //   cursorColor: Colors.black,
                //   decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                //     border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                //     labelText: "学号",
                //     labelStyle: TextStyle(color: Colors.black)),
                //   onChanged: (text) => logic.username = text,
                //   onFieldSubmitted: (text) => logic.username = text,
                // ),
                // Container(height: 60),
                // TextFormField(
                //   cursorColor: Colors.black,
                //   decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                //     border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                //     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                //     labelText: "密码",
                //     labelStyle: TextStyle(color: Colors.black)),
                //   onChanged: (text) => logic.password = text,
                //   onFieldSubmitted: (text) => logic.password = text,
                // ),
                Container(height: 30),
                nexButton(
                  "确定",
                  onTap: () => Get.offAndToNamed(Routes.navigation), //logic.checkLogin(),
                  // child: const Text("确定",style: TextStyle(fontSize: 24),),
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

  Widget fieldColorBox(String title, String input) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: FractionalOffset(0.0, 0.4), end: FractionalOffset(0.9, 0.7),
            stops: [0.1, 0.9], colors: [Colours.YELLOW, Colours.BLUE]),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 30,
            offset: Offset(1.0, 9.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 2,
            child: Wrap(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 12, color: Colors.black)),
                  onChanged: (text) => input = text,
                  onFieldSubmitted: (text) => input = text,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nexButton(String text, {Function()? onTap}) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.clamp,
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
            stops: [0.4, 1],
            colors: [Colors.black, Colors.black54],
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colours.YELLOW,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}