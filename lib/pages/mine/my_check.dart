import 'package:classes/base/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyCheck extends BasePage{
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("签到记录")),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(10, (index) => checkItem()),
        ),
      ),
    );
  }

  Widget checkItem() {
    return Column(
      children: [
        Row(
          children: [],
        )
      ],
    );
  }


}