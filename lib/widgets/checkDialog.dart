import 'package:classes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckDialog extends StatelessWidget {
  const CheckDialog({Key? key, required this.title, this.yes="是", this.no="否", this.doYes, this.doNo}) : super(key: key);

  final String title;
  final String yes;
  final String no;
  final Function()? doYes;
  final Function()? doNo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 80,maxWidth: 160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 5,
                child: Container(
                    width: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 10,
                            blurStyle: BlurStyle.solid,
                            offset: Offset(4, 6)
                        )],
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        color: Colors.white
                    ),
                    child: Text(title))),
            Container(height: 10),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 87,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              blurRadius: 5,
                              blurStyle: BlurStyle.solid,
                              offset: Offset(4, 6)
                          )],
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                          color: Colors.white
                      ),
                      child: Text(no)).tap(doNo??Get.back),
                  Container(width: 8),
                  Container(
                      width: 87,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              blurRadius: 5,
                              blurStyle: BlurStyle.solid,
                              offset: Offset(4, 6)
                          )],
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
                          color: Colors.white
                      ),
                      child: Text(yes)).tap(doYes),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
