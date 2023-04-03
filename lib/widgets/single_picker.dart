import 'package:classes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'button.dart';

class SinglePicker extends StatefulWidget {
  const SinglePicker({Key? key, required this.list, required this.initIndex}) : super(key: key);

  final List list;
  final int initIndex;

  @override
  State<SinglePicker> createState() => _SinglePickerState();
}

class _SinglePickerState extends State<SinglePicker> {
  var index = 0;
  late FixedExtentScrollController controller = FixedExtentScrollController(initialItem: widget.initIndex);
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
                      onTap: () => Get.back(result: {index: widget.list[index]}))
                ],
              ),
              SizedBox(
                height: 200,
                child: CupertinoPicker(
                    itemExtent: 30,
                    scrollController: controller,
                    onSelectedItemChanged: (position) {
                      setState(() {
                        index = position;
                      });
                    },
                    children: widget.list.map((e) => Center(child: Text(e.toString(),style: TextStyle(fontSize: 17)))).toList()),
              ),
            ],
          ),
        );
      },
    );
  }
}