import 'dart:ui';
import 'package:classes/base/base_controller.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/sign_in/sign_in_logic.dart';
import 'package:classes/res/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SignInPage extends BasePage{
  SignInPage({super.key});

  final controller = Get.put(SignInLogic());

  @override
  Widget buildWidget() {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQueryData.fromWindow(window).padding.top + 60,
          horizontal: 40,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
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
                  Get.toNamed(Routes.navigation);
                },
                child: const Text("登录"),
              )
            ],
          ),
        ),
      ),
    );
  }

}