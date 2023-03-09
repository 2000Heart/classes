import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/sign_in/sign_in_logic.dart';
import 'package:classes/res/colours.dart';
import 'package:classes/utils/sp_utils.dart';
import 'package:classes/utils/toast_utils.dart';
import 'package:classes/widgets/choose_text.dart';
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
            waveType: WaveType.liquidReveal,
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
      color: Color(0xfffbe8e8),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                "简之", textStyle: const TextStyle(fontSize: 80),
                speed: const Duration(seconds: 2),
                colors: [Colours.PURPLE,Colours.RED_LIGHT,Colours.PURPLE,Colours.RED_LIGHT,Colours.PURPLE],
              )],
            repeatForever: true,
            pause: const Duration(),
          ),
          Container(height: 300),
          NormalButton.rect(
            width: 240,
            height: 50,
            onTap: () {
              logic.isLogin = true;
              logic.liquidController.jumpToPage(page: 3);
            },
            text: "登录",
            textStyle: const TextStyle(fontSize: 20)),
          Container(height: 40),
          NormalButton.rect(
              width: 240,
              height: 50,
              onTap: () {
                logic.isLogin = false;
                logic.liquidController.animateToPage(page: 1,duration: 700);
              },
              text: "注册",
              textStyle: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget chooseIdentity() {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(
        begin: FractionalOffset(0.0, 0.4), end: FractionalOffset(0.9, 0.7),
        stops: [0.1, 0.9], colors: [Color(0xFFD3F4FF), Colours.BLUE],
      )),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 66),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 0,
                offset: Offset(0.0, 32.0))],
            borderRadius: BorderRadius.circular(16.0),
            gradient: const LinearGradient(
                begin: FractionalOffset(0.0, 0.4),
                end: FractionalOffset(0.9, 0.7),
                stops: [0.2, 0.9],
                colors: [Color(0xffFFC3A0), Color(0xffFFAFBD),])),
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(colors: [Colours.SIGNUP_RED,Colours.RED_LIGHT]),
        //   borderRadius: BorderRadius.circular(15),
        //   boxShadow: [BoxShadow(
        //     color: Colors.black38,
        //     blurRadius: 10,
        //     offset: Offset(1.0, 9.0),
        //   ),]
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("你是", style: TextStyle(fontSize: 40)),
            Container(height: 40),
            NormalButton.rect(
                onTap: () {
                  logic.userType = 1;
                  logic.liquidController.animateToPage(page: 2, duration: 700);
                },
                text: "教师",
                width: 160,
                height: 50,
                textStyle: TextStyle(fontSize: 28)),
            Container(height: 10),
            Text("or", style: TextStyle(fontSize: 30)),
            Container(height: 10),
            NormalButton.rect(
                onTap: () {
                  logic.userType = 0;
                  logic.liquidController.animateToPage(page: 2,duration: 700);
                },
                text: "学生",
                width: 160,
                height: 50,
                textStyle: TextStyle(fontSize: 28))
          ],
        ),
      ),
    );
  }

  Widget chooseSchool() {
    return GetBuilder<SignInLogic>(builder: (logic) {
      return Container(
        decoration: const BoxDecoration(gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.4), end: FractionalOffset(0.8, 0.7),
          stops: [0.1, 0.9], colors: [Colours.BLUE_DEEP, Colours.BLUE],
        )),
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 220,horizontal: 30),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
          decoration: BoxDecoration(
            boxShadow: const [BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(0.0, 32.0))],
            borderRadius: BorderRadius.circular(16.0),
            gradient: const LinearGradient(
              begin: FractionalOffset(0.0, 0.4),
              end: FractionalOffset(0.9, 0.7),
              stops: [0.2, 0.9],
              colors: [Color(0xffFFC3A0), Color(0xffFFAFBD)])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("你来自哪里？", style: TextStyle(fontSize: 40)),
              Container(height: 40),
              ChooseText(
                horizontal: 50,
                title: "学校",
                data: List.generate(logic.schoolList.length, (index) => logic.schoolList[index].schoolName ?? ""),
                onChanged: (str) => logic.school = str,
                  onSelected: (selection) => logic.school = selection
              ),
              Container(height: 20),
              ChooseText(
                horizontal: 50,
                title: "班级",
                data: List.generate(logic.classList.length, (index) => logic.classList[index].schoolName ?? ""),
                onChanged: (str) => logic.classInfo = str,
                onSelected: (selection) => logic.classInfo = selection
              ),
              Container(height: 40),
              NormalButton(
                width: 130,
                text: "确定",
                textStyle: const TextStyle(fontSize: 20),
                onTap: () => logic.school != "" && logic.classInfo != ""?
                logic.liquidController.animateToPage(page: 3,duration: 700):
                ToastUtils.show("请完善信息后再继续"), //logic.checkLogin(),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget completeAccount() {
    return GetBuilder<SignInLogic>(
      builder: (logic) {
        return Container(
          color: Color(0xffccf7e2),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            // key: GlobalKey<FormState>(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 70),
                fieldColorBox("学号", (str) => logic.username = str),
                Container(height: 40),
                fieldColorBox("密码",(str) => logic.password = str),
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
                Container(height: 90),
                NormalButton(
                  width: 160,
                  height: 50,
                  text: "确定",
                  textStyle: const TextStyle(fontSize: 14),
                  onTap: () {
                    if(logic.password != "" && logic.username != ""){
                      Get.offAndToNamed(Routes.navigation);
                      logic.isLogin?logic.checkLogin():logic.createUser();
                    }else{ToastUtils.show("请输入用户名与密码");}
                  },
                ),
                // Text(logic.user.toString())
              ],
            ),
          ),
        );
      }
    );
  }

  Widget fieldColorBox(String title, Function(String)? onChanged) {
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
            width: 16,
          ),
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 4,
            child: Wrap(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14, color: Colors.black)),
                  onChanged: onChanged,
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