import 'package:classes/base/base_page.dart';
import 'package:classes/res/utils.dart';
import 'package:flutter/material.dart';

class Setting extends BasePage{
  const Setting({super.key});

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("设置")),
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    blurStyle: BlurStyle.solid,
                    offset: Offset(5, 5)
                )
              ]
          ),
          child: Column(
            children: [
              [Text("注销账户",style: TextStyle(fontSize: 15)),Icon(Icons.arrow_forward_ios_rounded,size: 18)].formLine(),
            ],
          )
      ),
    );
  }

}