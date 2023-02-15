import 'package:cached_network_image/cached_network_image.dart';
import 'package:classes/base/base_controller.dart';
import 'package:classes/base/base_page.dart';
import 'package:classes/logic/lessons/lessons_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LessonsPage extends BasePage{
  LessonsPage({super.key});

  final logic = Get.put(LessonsLogic());

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(10, (index) => lessonsListItem()),
      ),
    );
  }

  Widget lessonsListItem(){
    return Container(
      margin: EdgeInsets.only(bottom: 5,left: 16,right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              offset: const Offset(0, 5),
              blurRadius: 5,
              spreadRadius: -8
          )
        ],
        borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            color: Colors.redAccent,
            child: Text("形")
            // CachedNetworkImage(
            //   width: 60,
            //   height: 60,
            //   imageUrl: "",
            //   errorWidget: (context, url, error) => Container(),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("形势与政策"),
                Text("当前第七周，进行中"),
                Text("2308")
              ],
            ),
          )
        ],
      ),
    );
  }
}