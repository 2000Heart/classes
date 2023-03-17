import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'button.dart';

class ItemPicker extends StatefulWidget {
  const ItemPicker({Key? key}) : super(key: key);

  @override
  State<ItemPicker> createState() => _ItemPickerState();
}

class _ItemPickerState extends State<ItemPicker> {
  List<String> list = Get.arguments;
  String? result;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      elevation: 40,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(16))
      ),
      constraints: BoxConstraints(
          maxWidth: Get.width),
      onClosing: () {  },
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10,bottom: 30,top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NormalButton.rect(text: "取消", width: 80,height: 35,onTap: Get.back),
                  NormalButton.rect(text: "确认", width: 80,height: 35,
                      onTap: () => Get.back(result: result))
                ],
              ),
              SizedBox(
                height: 200,
                child: CupertinoPicker(
                    itemExtent: 30,
                    onSelectedItemChanged: (position) => result = list[position],
                    children: list.map((e) => Center(child: Text(e,style: TextStyle(fontSize: 17)))).toList()),
              ),
            ],
          ),
        );
      },
    );
  }
}
